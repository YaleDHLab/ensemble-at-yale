class SubjectSetsController < ApplicationController
  respond_to :json

  def index
    # puts 'PARAMS: ', params
    workflow_id  = params["workflow_id"]
    random = params["random"] || false
    limit  = params["limit"].to_i  || 10

    if  workflow_id
      query = {"counts.#{workflow_id}.active_subjects" => {"$gt"=>0}}
    else
      query = {}
    end

    if params["random"]
      sets = Kaminari.paginate_array(SubjectSet.random(selector: query)).page(params[:page])
    else
      sets = SubjectSet.where(query).page(params[:page])
    end

    subject_set_pagination_info =
        {
        current_page: sets.current_page,
        next_page: sets.next_page,
        prev_page: sets.prev_page,
        total_pages: sets.total_pages,
      }

    respond_with sets, each_serializer: SubjectSetSerializer, workflow_id: workflow_id, limit: limit, random: random, subject_set_pagination_info: subject_set_pagination_info

  end

  def show
    # puts 'PARAMS: ', params
    # limit = 1 # should only return one (the matched set)
    subject_id = params[:subject_id]
    page = params[:page].to_i
    # limit = params["limit"].to_i || 10
    # puts 'SUBJECT SET ID: ', params[:subject_set_id]
    set = SubjectSet.where(id: params[:subject_set_id])
    workflow_id  = params["workflow_id"]

    return render status: 404, json: {status: 404} if set.nil?
    respond_with set, status: (set.nil? ? :not_found : 201), each_serializer: SubjectSetSerializer, workflow_id: workflow_id, subject_id: subject_id, limit: limit, page: page
  end

end
