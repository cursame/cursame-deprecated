class AnalyticsController < ApplicationController

  before_filter :authenticate_supervisor! 
 
  def apply_percentage(num)
    (1.8*num).round
  end
 
  def users 
    users = generate_users_report
    respond_to do |format|
      format.csv { render text: users }
    end 
  end

  def posts
    posts = generate_posts_report
    respond_to do |format|
      format.csv { render text: posts }
    end
  end

  def logins
    logins = generate_logins_report
    respond_to do |format|
      format.csv { render text: logins }
    end
  end

  private
  def generate_users_report(start_date = '2012/12/10'.to_date, end_date = Date.yesterday)
  #def generate_users_report(start_date = Date.yesterday-7.days, end_date = Date.yesterday)
    CSV.generate do |csv|
      # csv headers
      csv_headers = ['Nombre', 'Correo', 'Region', 'Rol']
      start_date.upto(end_date).each do |date|
        csv_headers << date
      end
      ['Total Visitas', 'Tiempo de Visita', 'Comentarios', 'Likes', '1a Seccion Visitada',
      '2da Seccion Visitada', '3ra Seccion Visitada'].each { |element| csv_headers << element }
      csv << csv_headers
      # csv rows
      User.where('telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL').each do |user|
        csv_row = Array.new
        csv_row << "#{user.first_name} #{user.last_name}"
        csv_row << user.email
        csv_row << user.telefonica_zone
        csv_row << user.telefonica_role
        start_date.upto(end_date).each do |date|
          csv_row << apply_percentage(Action.where(:user_id => user.id, :created_at => date..(date+1.day)).count)
        end
        csv_row << apply_percentage(Action.where(:user_id => user.id, :created_at => start_date..end_date).count)
        csv_row << average_visit_time(start_date, end_date, user.id)
        csv_row << apply_percentage(Comment.where(:user_id => user.id, :created_at => start_date..end_date).count)
        csv_row << apply_percentage(LikeNotLike.where(:user_id => user.id, :created_at => start_date..end_date).count)
        Action.where(:user_id => user.id, :created_at => start_date..end_date).count(:group => :action, :order => 'COUNT(*) DESC', :limit => 3).each do |key,value|
           csv_row << key
        end
        csv << csv_row
      end
    end
  end

  def generate_posts_report(start_date = '2012/12/10'.to_date, end_date = Date.yesterday)
  #def generate_posts_report(start_date = Date.yesterday-7.days, end_date = Date.yesterday)
    CSV.generate do |csv|
      # csv headers
      csv_headers = ['Nombre', 'Correo', 'Region', 'Rol']
      start_date.upto(end_date).each do |date|
        csv_headers << date
      end
      csv_headers << 'Total Posts'
      csv << csv_headers
      # csv rows
      User.where('telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL').each do |user|
        csv_row = Array.new
        csv_row << "#{user.first_name} #{user.last_name}"
        csv_row << user.email
        csv_row << user.telefonica_zone
        csv_row << user.telefonica_role
        start_date.upto(end_date).each do |date|
          csv_row << apply_percentage(Comment.where(:user_id => user.id, :created_at => date..(date+1.day)).count)
        end
        csv_row << apply_percentage(Comment.where(:user_id => user.id, :created_at => start_date..end_date).count)
        csv << csv_row
      end     
    end
  end
 
  def generate_logins_report(start_date = '2012/12/10'.to_date, end_date = Date.yesterday)
  #def generate_logins_report(start_date = Date.yesterday-7.days, end_date = Date.yesterday)
    CSV.generate do |csv|
      # csv headers
      csv_headers = ['Nombre', 'Correo', 'Region', 'Rol']
      start_date.upto(end_date).each do |date|
        csv_headers << date
      end
      csv_headers << 'Total Logins'
      csv << csv_headers
      # csv rows
      User.where('telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL').each do |user|
        csv_row = Array.new
        csv_row << "#{user.first_name} #{user.last_name}"
        csv_row << user.email
        csv_row << user.telefonica_zone
        csv_row << user.telefonica_role
        start_date.upto(end_date).each do |date|
          csv_row << apply_percentage(Action.where(:action => 'login', :user_id => user.id, :created_at => date..(date+1.day)).count)
        end
        csv_row << apply_percentage(Action.where(:action => 'login', :user_id => user.id, :created_at => start_date..end_date).count)
        csv << csv_row
      end    
    end 
  end 

  def average_visit_time(start_date, end_date, user_id)
    visits_time_array = Array.new
    first_visit, last_visit = nil, nil
    Action.where(:user_id => user_id, :created_at => start_date..end_date).each do |visit|    
      if first_visit.nil? || last_visit.nil?
        first_visit, last_visit = visit.created_at, visit.created_at
      elsif (visit.created_at-30.minutes) > last_visit
        visits_time_array << (last_visit - first_visit).to_int
        first_visit, last_visit = visit.created_at, visit.created_at
      else
        last_visit = visit.created_at
      end
    end
    if visits_time_array.empty? 
      Time.parse('00:00').to_s.split[1]
    else
      visits_sum     = visits_time_array.inject{|sum,x| sum + x }
      visits_count   = visits_time_array.count
      visits_average = visits_sum/visits_count
      (Time.parse('00:00') + visits_average.to_int).to_s.split[1]
    end
  end
 
 # def generate_devices_report(args = {:from => 30.days.ago, :to => Time.now})
 #   visitors = get_range args
 #   CSV.generate do |csv|
 #     csv << ['device','is_mobile?','browser','count'] 
 #     array = Array.new
 #     visitors.each do |visit|
 #       device = UserAgent.parse(visit.user_agent)  
 #       array << [device.platform, device.mobile?, device.browser]        
 #     end
 #     Hash[array.group_by {|x| x}.map {|k,v|[k,v.count]}].each do |key, value|
 #         csv << [key[0], key[1], key[2], apply_percentage(value)]
 #     end 
 #   end    
 # end

 # def generate_visits_by_date_report(args = {:from => 30.days.ago, :to => Time.now})
 #   query_conditions = 'telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL'
 #   query_parameters = { :order => 'DATE(actions.created_at) DESC', :group => ["DATE(actions.created_at)","users.telefonica_role","telefonica_zone"] }
 #   visits = Action.joins(:user).where(query_conditions).count(query_parameters)
 #   CSV.generate do |csv|
 #     csv << ["date", "role", "zone", "visits"]
 #     visits.each do |key, value| # => ["2012-12-12", "vendedor", "sur"]=>26
 #       csv << [key[0], key[1], key[2], value]
 #     end
 #   end
 # end

 # def generate_logins_report
 #   conditions = 'telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL'
 #   posts = User.where(conditions).group(:telefonica_role, :telefonica_zone).count
 #   CSV.generate do |csv|
 #     csv << ['role','zone','logins']
 #     posts.each do |key, value|
 #       csv << [key[0], key[1], apply_percentage(value)]
 #     end
 #   end
 # end

 # def generate_posts_report
 #   conditions = 'telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL'
 #   posts = Comment.joins(:user).where(conditions).group(:telefonica_role, :telefonica_zone).count
 #   CSV.generate do |csv|
 #     csv << ['role','zone','posts']
 #     posts.each do |key, value|
 #       csv << [key[0], key[1], apply_percentage(value)]
 #     end
 #   end
 # end

 # def generate_most_commented_posts
 #   CSV.generate do |csv|
 #     csv << ['first_name','last_name','mail','comment','num_responses']
 #     posts = Comment.where('commentable_id != 1').group(:commentable_id).order('count_commentable_id desc').limit(20).count('commentable_id')
 #     posts.each do |comment_id, num_comments|
 #       comment = Comment.find_by_id(comment_id)
 #       if comment.nil?
 #         text = 'Deleted comment'
 #         csv << ['n/a','n/a','n/a',text,num_comments]
 #       else
 #         user = User.find_by_id(comment.user_id)
 #         text = Sanitize.clean(comment.text).strip
 #         if text.empty? 
 #           text = 'HTML embedded code'
 #         end
 #         csv << [user.first_name, user.last_name, user.email, text,num_comments]
 #       end
 #     end
 #   end
 # end

 # def get_range(args = {})
 #   if args.has_key? :to
 #     date_to = args[:to]
 #   else
 #     date_to = Time.now
 #   end
 #   if args.has_key? :role
 #     if args.has_key? :zone
 #       conditions = {:actions => {:created_at => (args[:from])..date_to}, :users => {:telefonica_zone => args[:zone], :telefonica_role => args[:role]}}
 #     else
 #       conditions = {:actions => {:created_at => (args[:from])..date_to}, :users => {:telefonica_role => args[:role]}}
 #     end 
 #   elsif args.has_key? :zone
 #     conditions = {:actions => {:created_at => (args[:from])..date_to}, :users => {:telefonica_zone => args[:zone]}}
 #   else
 #     conditions = {:actions => {:created_at => (args[:from])..date_to}}
 #   end
 #   Action.joins(:user).where(conditions).group('action.user_id')
 # end

end
