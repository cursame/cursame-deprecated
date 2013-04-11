desc "Actualiza los Top Users"
task :update_top_users => :environment do

  Ranking.delete_all
  
  User.all.each do |user|
    # sign ins
    user.top_user_score = !user.last_sign_in_at.nil? ? user.sign_in_count : 0 
    # comments
    user.top_user_score += Comment.where(:user_id => user.id).count
    # likes
    user.top_user_score += user.received_likes
    user.save
  end
  
  User.order('top_user_score DESC').first(10).each_with_index do |user,index|
    puts "top_user[#{index}] => { score: #{user.top_user_score}, id: #{user.id}, name: #{user.first_name} #{user.last_name} }"		
		Ranking.create('user_id' => user.id, 'top_users_id' => TopUsers.last.id ,'order' => index) 
	end
  
end