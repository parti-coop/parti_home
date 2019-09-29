module ApplicationHelper
  def body_class
    dasherized_controller_name = params[:controller].gsub(/\//, '--')
    arr = ["body-#{dasherized_controller_name}", "body-#{dasherized_controller_name}-#{params[:action]}"]
    arr.join(' ')
  end
end
