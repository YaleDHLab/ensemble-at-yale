class SubjectSetFirstPagesController < ApplicationController
  respond_to :json

  def index
    @requested_group_id = params[:group_id].to_str
    
    @first_pages_in_group = SubjectSetFirstPage.where(group_key_id: @requested_group_id).to_a

    # loop over the first pages in this group and ensure none are retired
    @active_first_pages_in_group = []

    @first_pages_in_group.each do |o|
      subject_set = SubjectSet.where("_id" => o.subject_set_id)[0]
      if subject_set.retired != 1
        @active_first_pages_in_group << o
      end
    end

    respond_to do |format|
      format.json { render json: @active_first_pages_in_group }
    end
  end
end