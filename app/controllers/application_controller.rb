class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_filter :adjust_format_for_iphone
  before_filter :allow_registrations
  after_filter :flash_to_headers

  def flash_to_headers
      return unless request.xhr?

      response.headers['X-Message'] = flash[:notice]  unless flash[:notice].blank?
      response.headers['X-Message'] = flash[:alert]   unless flash[:alert].blank?
      response.headers['X-Message'] = flash[:error]   unless flash[:error].blank?

      response.headers['X-Message-type'] = :info.to_s      unless flash[:notice].blank?
      response.headers['X-Message-type'] = :warning.to_s   unless flash[:alert].blank?
      response.headers['X-Message-type'] = :error.to_s     unless flash[:error].blank?

      flash.discard # don't want the flash to appear when you reload page
  end

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

  def flash_message(type, text)
      flash[type] ||= []
      flash[type] << text
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
