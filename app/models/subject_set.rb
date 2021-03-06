class SubjectSet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Randomizer

  paginates_per 2

  field :key,                    type: String
  field :name,                   type: String
  field :random_no ,             type: Float
  field :state ,                 type: String, default: "active"
  field :thumbnail,              type: String
  field :meta_data,              type: Hash
  field :counts,                 type: Hash

  # add field in which to store the number of times a user has
  # indicated there's nothing left to mark in this subject set
  field :nothing_left_to_mark,    type: Integer, default: 0
  field :retired_from_mark,       type: Integer, default: 0
  field :retired_from_transcribe, type: Integer, default: 0

  field :complete_secondary_subject_count,    type: Integer, default: 0
  field :active_secondary_subject_count,      type: Integer, default: 0

  belongs_to :group
  belongs_to :project
  has_many :subjects, dependent: :destroy, :order => [:order, :asc]

  def activate!
    state = "active"
    workflows.each{|workflow| workflow.inc(:active_subjects => 1 )}
    save
  end

  def inc_subject_count_for_workflow(workflow)
    self.inc("counts.#{workflow.id.to_s}.total_subjects" => 1)
  end

  def subject_deactivated_on_workflow(workflow)
    inc_subjects_on_workflow(workflow, -1)
  end

  def subject_activated_on_workflow(workflow)
    inc_subjects_on_workflow(workflow, 1)
  end

  def inc_subjects_on_workflow(workflow, inc)
    self.inc("counts.#{workflow.id.to_s}.active_subjects" => inc)
  end

  def subject_completed_on_workflow(workflow)
    self.inc("counts.#{workflow.id.to_s}.complete_subjects" => +1)
    self.inc("counts.#{workflow.id.to_s}.active_subjects" => -1)
  end

  def active_subjects_for_workflow(workflow)
    subject.active.for_workflow(workflow)
  end

  def self.autocomplete_name(field, letters)
    reg = /#{Regexp.escape(letters)}/i
    where( project: Project.current, :"meta_data.#{field}" => reg)
  end

  def workflows
    counts.map do |k,v|
      workflow = Workflow.find k
      v.merge workflow: workflow
    end
  end

  def to_s
    "#{state == 'inactive' ? '[Inactive] ' : ''}Subject Set"
  end

end
