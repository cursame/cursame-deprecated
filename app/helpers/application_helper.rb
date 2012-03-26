module ApplicationHelper
  def members_active
    if controller_name == "courses" && action_name == "members"
      "active"
    end
  end
  
end
