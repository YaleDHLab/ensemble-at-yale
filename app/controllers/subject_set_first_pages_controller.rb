class SubjectSetFirstPagesController < ApplicationController
  respond_to :json

  def index
    @requested_group_id = params[:group_id].to_str
    @first_pages_in_group = SubjectSetFirstPage.where(group_key_id: @requested_group_id).where(retired: 0).to_a
    @active_first_pages_in_group = []

    @retired_subject_set_ids = []
    @retired_subject_sets = SubjectSet.where(:retired => 1).entries
    @retired_subject_sets.each do |s|
      @retired_subject_set_ids << s._id
    end

    # remove any retired items from the array of thumbnails
    @first_pages_in_group.each do |o|
      if @retired_subject_set_ids.include? BSON::ObjectId(o.subject_set_id)
        # pass
      else
        @active_first_pages_in_group << o
      end
    end

    respond_to do |format|
      format.json { render json: @active_first_pages_in_group }
    end
  end
end