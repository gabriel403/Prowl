class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters
  include CanCan::ControllerAdditions

  before_action :check_auth
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied, with: :json_error

  private

  def authenticate_user_from_token!
    user_email = request.headers[:'X-Prowl-Auth'].presence
    user       = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, request.headers[:'X-Prowl-Token'])
      if user.updated_at < 30.minutes.ago
        return false
      end

      sign_in user, store: false
    end
  end

  def check_auth
    if !user_signed_in? && !['sessions', 'devise/sessions', 'devise/registrations', 'devise/confirmations', 'home'].include?(params[:controller])
      authenticate_user_from_token!
      authenticate_user!
    end
  end

  def json_error(error)
    render :json => {:message => error.message}, :status => :not_found
  end
end
