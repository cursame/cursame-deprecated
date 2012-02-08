module UserMailerHelper
  
  def comment_receiver(comment)
    receiver = comment.commentable
    if receiver.class == Discussion
      " en la discusion #{receiver.title}"
    elsif receiver.class == User
      if receiver != comment.user
        " en el muro de #{receiver.name}"
      else
        " en tu muro"
      end
    elsif receiver.class == Course
      " en el curso #{receiver.name}"
    end
  end
  
  def link_to_receiver(comment, subdomain)
    receiver = comment.commentable
    if receiver.class == Discussion
      url = link_to("Ver Discusion >>", discussion_url(receiver, :subdomain=>subdomain))
    elsif receiver.class == User
      url = link_to("Ver Comentario >>", wall_for_user_url(receiver, :subdomain=>subdomain))
    elsif receiver.class == Course
      url = link_to("Ver Comentario >>", wall_for_course_url(receiver, :subdomain=>subdomain))
    end
    "<h1>#{url}</h1>"
  end
  
end
