class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_filter :adjust_format_for_iphone
  before_filter :allow_registrations

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def adjust_format_for_iphone
    request.format = :ios if request.env["HTTP_USER_AGENT"] =~ %r{Mobile/.+Safari}
  end

  def allow_registrations
    app_setup = AppSetup.find_by name: 'registrations_open'
    if 'false' == app_setup.value
      authenticate_user!
    end
  end

end
