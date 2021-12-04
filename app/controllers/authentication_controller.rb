class AuthenticationController < Devise::OmniauthCallbacksController
  # We must disable CSRF check when Steam issues the callback request.
  skip_before_action :verify_authenticity_token

  def steam
    @player = Player.from_omniauth(request.env["omniauth.auth"])

    sign_in_and_redirect @player

  end

  def failure
    redirect_to root_path
  end
end
