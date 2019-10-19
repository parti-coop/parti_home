module ApplicationHelper
  def body_class
    dasherized_controller_name = params[:controller].gsub(/\//, '--')
    arr = ["body-#{dasherized_controller_name}", "body-#{dasherized_controller_name}-#{params[:action]}"]
    arr.join(' ')
  end

  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'bg-success'
    when 'error'
      'bg-danger'
    when 'alert'
      'bg-warning'
    when 'notice'
      'bg-info'
    else
      flash_type.to_s
    end
  end

  def i18n_for_flash(flash_type)
    case flash_type
    when 'success'
      '성공'
    when 'error'
      '오류'
    when 'alert'
      '경고'
    when 'notice'
      '안내'
    else
      flash_type.to_s
    end
  end

  def static_day_f(date)
    date.strftime("%Y.%m.%d")
  end

  def excerpt(text, options = {})
    return text if text.blank?

    options[:length] = 130 unless options.has_key?(:length)
    result = strip_tags(text)
    return result if result.blank?

    result = HTMLEntities.new.decode(result)
    return result.truncate(options[:length], options)
  end

  def is_kakao_talkable?
    browser.device.mobile?
  end
end
