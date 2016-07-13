class OmniauthCallbacksController < Devise::OmniauthCallbacksController

   def facebook
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

    if @user
      sign_in(@user, :bypass => true)
    end
    success_redirect
  end

  def zooniverse
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

    if @user
     sign_in(@user, :bypass => true)
    end
    success_redirect
  end

  def google_oauth2
    omniauth_hash = request.env["omniauth.auth"]
    google_email = omniauth_hash[:extra][:raw_info][:email]

    @user = User.find_for_oauth(omniauth_hash, current_user, google_email)

    if @user
      sign_in(@user, :bypass => true)
      @user.update_attribute(:sign_in_count, @user.sign_in_count + 1)
    end
    success_redirect
  end

  def twitter
    omniauth_hash = request.env["omniauth.auth"]
    info = omniauth_hash["info"]
    twitter_email = info["email"] ? info["email"] : omniauth_hash["uid"] + "@twitter.com"

    @user = User.find_for_oauth(omniauth_hash, current_user, twitter_email)

    if @user
      sign_in(@user, :bypass => true)
      @user.update_attribute(:sign_in_count, @user.sign_in_count + 1)
    end
   success_redirect
  end

  def cas
    omniauth_hash = request.env["omniauth.auth"]
    cas_email = omniauth_hash["uid"] + "@yale.edu"
    @user = User.find_for_oauth(omniauth_hash, current_user, cas_email)

    if @user
      sign_in(@user, :bypass => true)
      @user.update_attribute(:sign_in_count, @user.sign_in_count + 1)
    end
    success_redirect
   end

  private

  def success_redirect
    path = :root

    # Is there a URL to redirect to ?
    path = session.delete(:login_redirect) if session[:login_redirect]
    # Before redirecting them to an admin path, let's double check they're allowed
    path = :root if path.match(/^\/admin/) && ! @user.can_view_admin?

    redirect_to path
  end
end