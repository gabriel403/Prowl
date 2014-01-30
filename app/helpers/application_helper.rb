module ApplicationHelper
  def render_flash
    html = []
    flash.each do |type, messages|
      skey = type
      case type
      when :notice
        skey = :info
      when :alert
        skey = :warning
      end
      if messages.kind_of?(Array)
        messages.each do |m|
          # m.m_safe
          html << (content_tag :div, m, :class => "flash #{type} alert alert-#{skey} alert-dismissable pointer", :data => {:dismiss => "alert"}) unless m.blank?
        end
      else
        html << (content_tag :div, messages, :class => "flash #{type} alert alert-#{skey} alert-dismissable pointer", :data => {:dismiss => "alert"}) unless messages.blank?
      end
    end
    html.join('').html_safe
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
