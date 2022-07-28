module ApplicationHelper
  def enum_to_dict(e)
    e.map {|key, value| [key.titleize, e.key(value)]}
  end
end
