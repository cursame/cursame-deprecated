module SupervisorHelper
  
  def teachers_notification_tab(pending_teachers_total, tab)
    if pending_teachers_total > 0
      tab.teachers "#{t('.teachers')} <span class=\"label-tag notifications tip\" title=\"#{t('courses.requests.pending_requests')}\">#{pending_teachers_total}</span>".html_safe, supervisor_teachers_path
    else
      tab.teachers t('.teachers'), supervisor_teachers_path
    end
  end
  
  def link_to_pending_teachers(pending_teachers_total)
    extra_text = "<span class=\"label-tag notifications tip\" title=\"#{t('courses.requests.pending_requests')}\">#{pending_teachers_total}</span>" if pending_teachers_total > 0
    link_to "#{t('courses.teachers.pending')} #{extra_text}".html_safe, '#pending'
  end
  
  def class_for_active_li(type, li)
    if (type and type==li) or (type==nil and li=="approved")
      "active"
    end
  end
end
