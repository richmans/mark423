module ApplicationHelper
  def enum_to_dict(e)
    e.map {|key, value| [key.titleize, e.key(value)]}
  end

  def format_duration(d)
    Time.at(d.ceil).utc.strftime("%H:%M:%S")
  end

  def format_date(d)
    d.strftime("%d-%m-%Y")
  end

  def link_td(object, field, &block)
    edit_path = send("edit_#{object.class.name.downcase}_path", object)
    concat raw "<td class='#{field.to_s}'  onclick='javascript:window.location=\"#{edit_path}\"'>"
    concat link_to capture(&block), edit_path, :class =>'row_link'
    concat raw "</td>"
  end
  
  def current_controller()
    controller.controller_name.to_s
  end
  
  def current_action()
    controller.action_name.to_s 
  end
end
