# Extensive Docs at http://github.com/innku/innsights-gem
Rails.configuration.to_prepare do
  Innsights.setup do
    user User do
      display :name
      group :network
    end
  
    group Network do
      display :name
    end
  
    watch Comment do
      report lambda { |comment| "comment_#{comment.commentable.class.to_s.downcase}" }
      user :user
    end
    
    watch Course do
      report "new_course"
      user :owner
    end
    
    watch Enrollment do
      report lambda { |enrollment| "#{enrollment.role}_enrollment"}
      user :user
    end
    
    watch User do
      report lambda  { |user| "#{user.role}_registered"}
      # group :network # En caso de que se quiera un ranking de registros por red
    end
    
    watch SurveyReply do
      report "survey_reply"
      user :user
    end
    
    watch Delivery do
      report "new_delivery"
      user :user
    end
    
  end
end
