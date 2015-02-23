class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => auth.provider) if is_navigational_format?
    else
      session["devise.#{auth.provider}_data"] = request.env["omniauth.auth"].except("extra") # avoid CookieOverflow
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :twitter, :all
end
