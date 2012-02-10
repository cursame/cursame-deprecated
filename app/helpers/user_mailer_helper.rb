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
  
end
