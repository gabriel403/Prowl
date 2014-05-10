class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create]
  include Devise::Controllers::Helpers
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters

  respond_to :json

  def create
    super do |resource|
      resource.authentication_token = nil
      resource.save
    end
  end

  def destroy
    user_email = request.headers[:'X-Prowl-Auth'].presence
    user       = user_email && User.find_by_email(user_email)

    super

    user.authentication_token = nil
    user.save
  end
end
