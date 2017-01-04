class UsersController < ApplicationController
  respond_to :json

  def logged_in_user
    providers = User.auth_providers
    
    respond_with AuthStateSerializer.new(user: current_or_guest_user, providers: providers)
  end

  def tutorial_complete

    user = require_user!
    user.tutorial_complete!

    render json: AuthStateSerializer.new(user: current_or_guest_user, providers: User.auth_providers), status: 200
  end

  # method to save the route a user originally requested before they were challenged for auth
  def save_requested_route
    requested_route = params[:requested_route]
    session[:login_redirect] = requested_route
    head :ok # to refrain from supplying a template or response
  end

end
