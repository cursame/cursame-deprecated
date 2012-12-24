class AnalyticsController < ApplicationController

  def reporte_general(args = {:from => 30.days.ago, :to => Time.now})
    @visitors = User.all
  end

  private 
  def logins(args = {})
    sum = 0
    if args.has_key? :zone
      if args.has_key? :role
        User.find(:all, :conditions => ["telefonica_zone = ? AND telefonica_role = ?", args[:zone], args[:role]]).each { |user| sum+=user.sign_in_count }
      else
        User.find(:all, :conditions => ["telefonica_zone = ?", args[:zone]]).each { |user| sum+=user.sign_in_count }
      end
    elsif args.has_key? :role
      User.find(:all, :conditions => ["telefonica_role = ?", args[:role]]).each { |user| sum+=user.sign_in_count }
    else
      User.find(:all, :conditions => "telefonica_role IS NOT NULL").each { |user| sum+=user.sign_in_count }
    end
    return (sum*1.6).to_int
  end
  helper_method :logins

  def resumen
  end

  private
  def user_agent(args = {:from => 30.days.ago, :to => Time.now})
    if args.has_key? :zone
      if args.has_key? :role
        visitors = get_range :from => args[:from], :to => args[:to], :role => args[:role], :zone => args[:zone]
      else
        visitors = get_range :from => args[:from], :to => args[:to], :zone => args[:zone]
      end 
    elsif args.has_key? :role
      visitors = get_range :from => args[:from], :to => args[:to], :role => args[:role]
    else
      visitors = get_range :from => args[:from], :to => args[:to]
    end 
    array = []
    visitors.each do |action|
       user_agent = UserAgent.parse(action.user_agent)
       array << [user_agent.platform, user_agent.mobile?, user_agent.browser]
    end
    return Hash[array.group_by {|x| x}.map {|k,v|[k,v.count]}].sort 
  end
  helper_method :user_agent

  private
  def reporte_hora(args = {:from => 30.days.ago, :to => Time.now})
    if args.has_key? :zone
      if args.has_key? :role
        visitors = get_range :from => args[:from], :to => args[:to], :role => args[:role], :zone => args[:zone]
      else
        visitors = get_range :from => args[:from], :to => args[:to], :zone => args[:zone]
      end
    elsif args.has_key? :role
      visitors = get_range :from => args[:from], :to => args[:to], :role => args[:role]
    else
      visitors = get_range :from => args[:from], :to => args[:to]
    end
    array = []
    visitors.each { |action| array << action.created_at.to_s.split[1].split(':')[0] }
    return Hash[array.group_by {|x| x}.map {|k,v|[k,v.count]}].sort
  end
  helper_method :reporte_hora

  private
  def reporte_fecha(args = {:from => 30.days.ago, :to => Time.now})
    if args.has_key? :zone
      if args.has_key? :role
        visitors = get_range :from => args[:from], :to => args[:to], :role => args[:role], :zone => args[:zone]
      else
        visitors = get_range :from => args[:from], :to => args[:to], :zone => args[:zone]
      end
    elsif args.has_key? :role
      visitors = get_range :from => args[:from], :to => args[:to], :role => args[:role]
    else
      visitors = get_range :from => args[:from], :to => args[:to]
    end
    array = []
    visitors.each { |action| array << action.created_at.to_s.split[0] }
    return Hash[array.group_by {|x| x}.map {|k,v|[k,v.count]}].sort
  end
  helper_method :reporte_fecha

  private
  def reporte_user_agent
    user_agents = []
    visitors.each { |action| user_agents << action.user_agent }
    return Hash[user_agents.group_by {|x| x}.map {|k,v|[k,v.count]}]
  end
  helper_method :reporte_user_agent

  private
  def visitas(args = {})
    visitors = Action.joins('LEFT OUTER JOIN users ON users.id = actions.user_id').where :created_at => (args[:from])..args[:to], :user_id => args[:user_id]
    count, first_loop, last_visit = 0, true, nil
    visitors.each do |visitor|
      visit = visitor.created_at.to_datetime
      last_visit, first_loop = [visit, false] if first_loop
      if visit > last_visit - 30.minutes
        count += 1
      end
      last_visit = visit
    end
    return count
  end
  helper_method :visitas

  private
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
    query = 'LEFT OUTER JOIN users ON users.id = actions.user_id'
    return Action.joins(query).where(conditions).group(:user_id)
  end

end
