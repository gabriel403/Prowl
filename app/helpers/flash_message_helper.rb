module FlashMessageHelper
  def flash_message
    html = ""
    flash.each do |key, msg|
      skey = key
      case key
      when :notice
        skey = :info
      when :alert
        skey = :warning
      end

      html << (content_tag :div, msg, :class => "flash #{key} alert alert-#{skey}")
    end
    html.html_safe
  end
end