class GroupStatsController < ApplicationController
  respond_to :json

  # curl http://localhost:3000/group_stats?group_id=596d02bd23c5155771afa2d5
  def index
    
    # parse out group attributes
    @requested_group_id = params[:group_id].to_str
    @group = Group.find(@requested_group_id)
    @group_key = @group['meta_data']['key']

    # secondary annotations have subject_set_id attributes, but not meta_data,
    # so find all subject sets for this group
    @subject_sets = SubjectSet.where('meta_data.group_key': @group_key)
    @subject_set_ids = @subject_sets.all.pluck(:_id)

    # identify the total number of subject sets retired from marking and transcribing
    @retired_from_mark = @subject_sets.where(:retired_from_mark => 1).entries.length
    @retired_from_transcribe = @subject_sets.where(:retired_from_transcribe => 1).entries.length
    @total_completed = @subject_sets.where(:retired_from_mark => 1).where(:retired_from_transcribe => 1).entries.length

    # get the marks for this group. NB: root subjects are pages themselves
    @marks = Subject.where(:type.nin => ['root'])
    @group_marks = @marks.where(:subject_set_id.in => @subject_set_ids)
    @mark_data = @group_marks.all.pluck(:data)

    # among those marks, count the 'marks' and the transcriptions
    @mark_count = 0
    @transcription_count = 0
    @mark_data.each do |m|
      if m.key?('color')
        @mark_count += 1
      else
        @transcription_count += 1
      end
    end

    @response = [{
      'retired_from_mark': @retired_from_mark,
      'retired_from_transcribe': @retired_from_transcribe,
      'total_subject_sets': @subject_set_ids.length,
      'total_marks': @mark_count,
      'total_transcriptions': @transcription_count,
      'total_completed': @total_completed
    }]

    respond_to do |format|
      format.json { render json: @response }
    end
  end
end