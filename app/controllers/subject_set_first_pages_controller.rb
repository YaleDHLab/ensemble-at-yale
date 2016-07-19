class SubjectSetFirstPagesController < ApplicationController
  respond_to :json

  def index
    @requested_group_id = params[:group_id].to_str
    
    @first_pages_in_group = SubjectSetFirstPage.where(group_key_id: @requested_group_id).to_a

    respond_to do |format|
      format.json { render json: @first_pages_in_group }
    end
  end
end