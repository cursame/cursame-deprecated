class Asset < ActiveRecord::Base
  include ExportToCsv

  belongs_to :owner, :polymorphic => true
  attr_accessible :file
  mount_uploader :file, AssetUploader

  def self.import_csv(id, role = 'teacher', network_id)
    find(id).import_users(role, network_id)
  end

  def import_users(role, network_id)
    invalid_users = []
    network = Network.find network_id

    CSV.parse(file.read, :headers => true) do |row|
      user = User.new(:email => row["email"],
                      :role => role, 
                      :state => "active", 
                      :first_name => row["first name"].strip.capitalize, 
                      :last_name => row["last name"].strip.capitalize,
                      :terms_of_service => "1")
      user.networks = [network]
      password = Devise.friendly_token[0,20]
      user.password = password
      user.confirmed_at = DateTime.now
      if user.save
        UserMailer.new_user_by_supervisor(user, network, password).deliver
      else
        puts user.errors.full_messages
        invalid_users << user
      end
    end
    Notification.create :user => self.owner, :notificator => self, :kind => 'finished_uploading_users'
    if !invalid_users.blank?
      invalid_users_csv = export_users_to_csv(invalid_users)
      SupervisorMailer.finished_upload_users(self.owner, network.subdomain, invalid_users_csv).deliver
    end
  end

  
end
