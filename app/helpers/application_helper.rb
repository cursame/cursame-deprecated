module ApplicationHelper
  def members_active
    if controller_name == "courses" && action_name == "members"
      "active"
    end
  end
  
  def class_for_active_li(type, li)
    if (type and type==li) or (type==nil and li=="current")
      "active"
    end
  end
end
