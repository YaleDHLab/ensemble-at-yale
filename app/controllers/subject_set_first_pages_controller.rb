class SubjectSetFirstPagesController < ApplicationController
  respond_to :json

  def index
    @all_first_pages = SubjectSetFirstPage.all
    respond_to do |format|
      format.json { render json: @all_first_pages }
    end
  end
end