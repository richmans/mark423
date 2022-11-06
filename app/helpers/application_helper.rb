module ApplicationHelper
  def enum_to_dict(e)
    e.map {|key, value| [key.titleize, e.key(value)]}
  end

  def format_duration(d)
    Time.at(d.ceil).utc.strftime("%H:%M:%S")
  end

  def current_controller()
    controller.controller_name.to_s
  end
  
  def current_action()
    controller.action_name.to_s 
  end
end
