class Asset < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  mount_uploader :file, AssetUploader

  def self.import_csv(id, role = 'teacher', network_id)
    find(id).import_users(role, network_id)
  end

  def import_users(role, network_id)
    invalid_users = []
    network = Network.find network_id

    CSV.open(file.url, "r").each do |row|
      user = User.new(:email => row[2],
                   :role => role, 
                   :state => "active", 
                   :first_name => row[0].strip.capitalize, 
                   :last_name => row[1].strip.capitalize,
                   :terms_of_service => "1")
      if user.valid?
        user.networks = [network]
        password = Devise.friendly_token[0,20]
        user.password = password
        user.confirmed_at = DateTime.now
        if user.save
          UserMailer.new_user_by_supervisor(user, network, password).deliver
        end
      else
        puts user.errors.full_messages
        invalid_users << user
      end
    end
  end

  
end
