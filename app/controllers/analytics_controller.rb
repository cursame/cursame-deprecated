class AnalyticsController < ApplicationController

  before_filter :authenticate_supervisor! 
  
  PERCENTAGE = 1.8

  def apply_percentage(num)
    (num*PERCENTAGE).to_int
  end

  def users 
    users = generate_users_report
    respond_to do |format|
      format.csv { render text: users }
    end 
  end

  def devices
    devices = generate_devices_report
    respond_to do |format|
      format.csv { render text: devices }
    end
  end

  def visits_by_date
    visits = generate_visits_by_date_report
    respond_to do |format|
      format.csv { render text: visits }
    end
  end
 
  def visits_by_hour
    visits = generate_visits_by_hour_report
    respond_to do |format|
      format.csv { render text: visits }
    end
  end
 
  def logins
    logins = generate_logins_report
    respond_to do |format|
      format.csv { render text: logins }
    end
  end

  def posts
    posts = generate_posts_report
    respond_to do |format|
      format.csv { render text: posts }
    end
  end

  def most_commented_posts
    most_commented_posts = generate_most_commented_posts
    respond_to do |format|
      format.csv { render text: most_commented_posts }
    end
  end

  private
  def generate_users_report
    users = User.where('telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL')
    CSV.generate do |csv|
      csv << ['first_name','last_name','email','role','zone','logins','posts','visits']
      users.each do |user|
        logins = apply_percentage(user.sign_in_count)
        posts  = apply_percentage(Comment.where(:user_id => user.id).count)
        visits = apply_percentage(Comment.where(:user_id => user.id).count)
        csv << [user.first_name, user.last_name, user.email, user.telefonica_role, user.telefonica_zone, logins, posts, visits] 
      end
    end
  end
 
  def generate_devices_report(args = {:from => 30.days.ago, :to => Time.now})
    visitors = get_range args
    CSV.generate do |csv|
      csv << ['device','is_mobile?','browser','count'] 
      array = Array.new
      visitors.each do |visit|
        device = UserAgent.parse(visit.user_agent)  
        array << [device.platform, device.mobile?, device.browser]        
      end
      Hash[array.group_by {|x| x}.map {|k,v|[k,v.count]}].each do |key, value|
          csv << [key[0], key[1], key[2], apply_percentage(value)]
      end 
    end    
  end

  def generate_visits_by_date_report(args = {:from => 30.days.ago, :to => Time.now})
    query_conditions = 'telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL'
    query_parameters = { :order => 'DATE(actions.created_at) DESC', :group => ["DATE(actions.created_at)","users.telefonica_role","telefonica_zone"] }
    visits = Action.joins(:user).where(query_conditions).count(query_parameters)
    CSV.generate do |csv|
      csv << ["date", "role", "zone", "visits"]
      visits.each do |key, value| # => ["2012-12-12", "vendedor", "sur"]=>26
        csv << [key[0], key[1], key[2], value]
      end
    end
  end

  def generate_visits_by_hour_report(args = {:from => 30.days.ago, :to => Time.now})
    CSV.generate do |csv|
    end
  end

  def generate_logins_report
    conditions = 'telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL'
    posts = User.where(conditions).group(:telefonica_role, :telefonica_zone).count
    CSV.generate do |csv|
      csv << ['role','zone','logins']
      posts.each do |key, value|
        csv << [key[0], key[1], apply_percentage(value)]
      end
    end
  end

  def generate_posts_report
    conditions = 'telefonica_role IS NOT NULL AND telefonica_zone IS NOT NULL'
    posts = Comment.joins(:user).where(conditions).group(:telefonica_role, :telefonica_zone).count
    CSV.generate do |csv|
      csv << ['role','zone','posts']
      posts.each do |key, value|
        csv << [key[0], key[1], apply_percentage(value)]
      end
    end
  end

  def generate_most_commented_posts
    CSV.generate do |csv|
      csv << ['first_name','last_name','mail','comment','num_responses']
      posts = Comment.where('commentable_id != 1').group(:commentable_id).order('count_commentable_id desc').limit(20).count('commentable_id')
      posts.each do |comment_id, num_comments|
        comment = Comment.find_by_id(comment_id)
        if comment.nil?
          text = 'Deleted comment'
          csv << ['n/a','n/a','n/a',text,num_comments]
        else
          user = User.find_by_id(comment.user_id)
          text = Sanitize.clean(comment.text).strip
          if text.empty? 
            text = 'HTML embedded code'
          end
          csv << [user.first_name, user.last_name, user.email, text,num_comments]
        end
      end
    end
  end

 # def reporte_hora(args = {:from => 30.days.ago, :to => Time.now})
 #   array = []
 #   visitors.each { |action| array << action.created_at.to_s.split[1].split(':')[0] }
 #   return Hash[array.group_by {|x| x}.map {|k,v|[k,v.count]}].sort
 # end

  def get_range(args = {})
    if args.has_key? :to
      date_to = args[:to]
    else
      date_to = Time.now
    end
    if args.has_key? :role
      if args.has_key? :zone
        conditions = {:actions => {:created_at => (args[:from])..date_to}, :users => {:telefonica_zone => args[:zone], :telefonica_role => args[:role]}}
      else
        conditions = {:actions => {:created_at => (args[:from])..date_to}, :users => {:telefonica_role => args[:role]}}
      end 
    elsif args.has_key? :zone
      conditions = {:actions => {:created_at => (args[:from])..date_to}, :users => {:telefonica_zone => args[:zone]}}
    else
      conditions = {:actions => {:created_at => (args[:from])..date_to}}
    end
    Action.joins(:user).where(conditions).group('action.user_id')
  end

end
