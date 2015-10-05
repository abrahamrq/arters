module ApplicationHelper
  def sweet_alert_title(symbol)
    return 'Success' if symbol == :success
    return 'Info' if symbol == :info
    return 'Error' if symbol == :error
    return 'Input' if symbol == :input
    'Warning'
  end
end
