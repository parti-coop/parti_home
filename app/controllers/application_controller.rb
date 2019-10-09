class ApplicationController < ActionController::Base
  def errors_to_flash(model)
    flash[:notice] = errors_to_str(model, '<br>').html_safe
  end

  def errors_to_str(model, br)
    return if model.errors.empty?
    result ||= ""
    result += model.errors.full_messages.join(br)
    result
  end
end
