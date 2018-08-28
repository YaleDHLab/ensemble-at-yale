class Classification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location
  field :task_key,                        type: String
  field :annotation,                      type: Hash, default: {}
  field :tool_name

  field :started_at
  field :finished_at
  field :user_agent

  belongs_to    :workflow, :foreign_key => "workflow_id"
  belongs_to    :user
  belongs_to    :subject, foreign_key: "subject_id", inverse_of: :classifications
  belongs_to    :child_subject, class_name: "Subject", inverse_of: :parent_classifications

  after_create  :increment_subject_classification_count #, :check_for_retirement_by_classification_count
  after_create  :generate_new_subjects
  after_create  :generate_terms
  # removing this after create until we have a use case for the information
  after_create  :increment_subject_set_classification_count
  after_create :update_subject_set_mark_transcribe_counts

  scope :by_child_subject, -> (id) { where(child_subject_id: id) }
  scope :having_child_subjects, -> { where(:child_subject_id.nin => ['', nil]) }
  scope :not_having_child_subjects, -> { where(:child_subject_id.in => ['', nil]) }

  index({child_subject_id: 1}, {background: true})
  index({created_at: 1}, {background: true})

  """
  After saving an annotation, check if the annotation was the final stage of the Mark
  workflow. If so, fetch the subject set to which the annotated subject belongs,
  increment the number of times users have completed the Mark stage for this subject set,
  and then check to see if this subject set should be retired.

  If the annotation is a transcription of a marked field, check if this annotation
  retires its given mark. If so, check if the subject is retired from marking. If so,
  check if all of the subject set's marks are retired. If so, retire the given subject
  set from the transcription workflow and change the subject set's status to retired
  """

  def update_subject_set_mark_transcribe_counts

    # first handle the case of user indicating there's nothing left to mark
    workflow = Workflow.find(self.workflow_id)

    if workflow.name == "mark"
      if self["task_key"] == "completion_assessment_task"
        annotation_value = self["annotation"]["value"]

        # annotation is either "complete_subject" or "incomplete_subject"
        if annotation_value == "complete_subject"

          # if the user indicated this subject is complete, increment
          # the number of times users have indicated there's nothing
          # left to mark
          subject = Subject.find(self.subject_id)
          subject_set = SubjectSet.find(subject.subject_set_id)
          subject_set.inc(nothing_left_to_mark: 1)

          # then check to see if this subject set should be retired
          self.conditionally_retire_from_mark(subject.subject_set_id)
          self.conditionally_retire_from_transcribe(subject.subject_set_id)
        end
      end

    # if this a transcription, check first if the subject is retired from marking
    elsif workflow.name == "transcribe"
      self.conditionally_retire_from_transcribe(subject.subject_set_id)
    end

  end

  def conditionally_retire_from_mark(subject_set_id)
    minimum_votes_to_retire = 2
    subject_set = SubjectSet.where('_id' => subject_set_id).entries.first
    votes_to_retire = subject_set.nothing_left_to_mark
    if votes_to_retire >= minimum_votes_to_retire
      subject_set.update_attributes(:retired_from_mark => 1)
      self.retire_subject_set_first_page_from_mark(subject_set_id)
    end
  end

  # if this subject's parent subject set is retired from marking and all
  # marks have been adequately transcribed, retire this subject's parent
  # subject set from transcription
  def conditionally_retire_from_transcribe(subject_set_id)
    subject_set = SubjectSet.find(subject_set_id)
    if subject_set.retired_from_mark == 1

      # check if there are any active subjects (aside from the root). If so,
      # this subject set can't be retired from transcription, else it can
      active_subjects = Subject.where(
        :subject_set_id => subject_set_id).where(
          :type.nin => ["root", nil]).where(
            :status => "active").entries.length

      # the root subject will always still be active
      if active_subjects == 0
        subject_set.update_attributes(:retired_from_transcribe => 1)
        self.retire_subject_set_first_page_from_transcribe(subject.subject_set_id)
      end
    end
  end

  # retire a subject set first page record from the mark workflow;
  # this information is only used in the group browser page, in order
  # to hide the "Mark" button from records that have been retired from
  # the mark workflow
  def retire_subject_set_first_page_from_mark(subject_set_id)
    subject_set_first_page = SubjectSetFirstPage.where(:subject_set_id => subject_set_id).entries.first
    subject_set_first_page.update_attributes(:retired_from_mark => 1)
  end

  def retire_subject_set_first_page_from_transcribe(subject_set_id)
    subject_set_first_page = SubjectSetFirstPage.where(:subject_set_id => subject_set_id).entries.first
    subject_set_first_page.update_attributes(:retired_from_transcribe => 1)
  end

  def generate_new_subjects
    if workflow.generates_subjects
      workflow.create_secondary_subjects(self)
    end
  end

  def check_for_retirement_by_classification_count(subject)
    if workflow.generates_subjects_method == "collect-unique"
      if subject.classification_count >= workflow.generates_subjects_after
        subject.retire!
      end
    end
  end

  def workflow_task
    workflow.task_by_key task_key
  end

  def generate_terms
    return if annotation.nil?
    annotation.each do |(k,v)|

      # Require a min length of 2 to index:
      next if v.nil? || v.size < 2
      # If task doesn't exist (i.e. completion_assessment_task, flag_bad_subject_task), skip:
      next if workflow_task.nil?

      tool_config = workflow_task.tool_config_for_field k
      next if tool_config.nil?

      # Is field configured to be indexed for "common" autocomplete?
      index_term = ! tool_config['suggest'].nil? && tool_config['suggest'] == 'common'
      next if ! index_term

      # Front- and back-end expect fields to be identifiable by workflow_id
      # and an annotation_key built from the task_key and field key
      #   e.g. "enter_building_address:value"
      key = "#{task_key}:#{k}"

      # puts "Term.index_term! #{workflow_id}, #{key}, #{v}"
      Term.index_term! workflow.id, key, v
    end
  end

  def increment_subject_set_classification_count
    subject.subject_set.inc classification_count: 1
  end

  def increment_subject_classification_count
    # TODO: Probably wrong place to be reacting to completion_assessment_task & flag_bad_subject_task
    # tasks; Should perhaps generalize and place elsewhere
    if self.task_key == "completion_assessment_task" &&
        self.annotation["value"] == "complete_subject"
      subject.increment_retire_count_by_one
    end

    if self.task_key == "flag_bad_subject_task"
      subject.increment_flagged_bad_count_by_one
      # Push user_id onto Subject.deleting_user_ids if appropriate
      Subject.where({id: subject.id}).find_one_and_update({
        "$addToSet" => {
          deleting_user_ids: user_id.to_s
        }
      })
    end

    if self.task_key == "flag_illegible_subject_task"
      subject.increment_flagged_illegible_count_by_one
    end
    # subject.inc classification_count: 1
    # Push user_id onto Subject.user_ids using mongo's fast addToSet feature, which ensures uniqueness
    subject_returned = Subject.where({id: subject_id}).find_one_and_update({
      "$addToSet" => {
        classifying_user_ids: user_id.to_s
      },
      "$inc" => {
        classification_count: 1}
      }, new: true)

    #Passing the returned subject as parameters so that we eval the correct classification_count
    check_for_retirement_by_classification_count(subject_returned)
  end

  def to_s
    ann = annotation.values.select {
      |v| v.match /[a-zA-Z]/
    }.map {
      |v| "\"#{v}\""
    }.join ', '
    ann = ann.truncate 40
    # {! annotation["toolName"].nil? ? " (#{annotation["toolName"]})" : ''}
    workflow_name = workflow.nil? ? '[Orphaned] ' : workflow.name.capitalize
    "#{workflow_name} Classification (#{ ann.blank? ? task_key : ann})"
  end

  # Returns hash mapping distinct values for given field to matching count:
  def self.group_by_hour(match={})
    agg = []
    agg << {"$match" => match } if match
    agg << {"$group" => {
      "_id" => {
        "y" => { '$year' => '$created_at' },
        "m" => { '$month' => '$created_at' },
        "d" => { '$dayOfMonth' => '$created_at' },
        "h" => { '$hour' => '$created_at' }
      },
      "count" => {"$sum" =>  1}
    }}
    self.collection.aggregate(agg).inject({}) do |h, p|
      h[p["_id"]] = p["count"]
      h
    end
  end
end
