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

  def devices
    devices = generate_devices_report
    respond_to do |format|
      format.csv { render text: devices }
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
 
  def generate_devices_report(start_date = '2012/12/10'.to_date, end_date = Date.yesterday)
  #def generate_devices_report(start_date = Date.yesterday-7.days, end_date = Date.yesterday)
    user_agents_array = Array.new
    Action.where(:created_at => start_date..end_date).each do |action|
      user_agent = UserAgent.parse(action.user_agent)
      user_agents_array << "#{user_agent.platform}, #{user_agent.browser}, #{user_agent.mobile?}"
    end
    CSV.generate do |csv|
      windows_os = { "Windows NT 6.2"  => "Windows 8",
                     "Windows NT 6.1"  => "Windows 7",
                     "Windows NT 6.0"  => "Windows Vista",
                     "Windows NT 5.2"  => "Windows XP x64 Edition",
                     "Windows NT 5.1"  => "Windows XP",
                     "Windows NT 5.01" => "Windows 2000, Service Pack 1 (SP1)",
                     "Windows NT 5.0"  => "Windows 2000",
                     "Windows NT 4.0"  => "Windows NT 4.0",
                     "Windows 98"      => "Windows 98",
                     "Windows 95"      => "Windows 95",
                     "Windows CE"      => "Windows CE" }
      # csv headers
      csv << ['Plataforma','Navegador','Tipo de Dispositivo','Accesos'] 
      result_hash = Hash.new(0)
      user_agents_array.each do |result|
        result_hash[result]+=1
      end
      result_hash.each do |key,value|
        result = key.split(',')
        browser = result[1]
        # platfrom parse
        if windows_os.has_key? result[0]
          platform = windows_os[result[0]]
        elsif result[0] =~ /[xX]11/
          platform = 'Unix/Linux'
        else
          platform = result[0]
        end
        # mobile identificator parse
        if result[2] =~ /true/
          mobile_flag = 'movil'
        else
          mobile_flag = 'computadora'
        end
        # csv rows
        csv << [platform, browser, mobile_flag, apply_percentage(value)]
      end
    end    
  end

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
