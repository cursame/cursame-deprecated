class Asset < ActiveRecord::Base
  include ExportToCsv

  belongs_to :owner, :polymorphic => true
  mount_uploader :file, AssetUploader

  def self.import_csv(id, role = 'teacher', network_id)
    find(id).import_users(role, network_id)
  end

  def import_users(role, network_id)
    invalid_users = []
    network = Network.find network_id

    CSV.parse(file.read.unpack("C*").pack("U*"), :headers => true) do |row|
      puts row["email"]
      user = User.new(:email => row["email"],
                      :role => role, 
                      :state => "active", 
                      :first_name => row["first_name"] ? row["first_name"].strip.capitalize : "Sin nombre", 
                      :last_name => row["last_name"] ? row["last_name"].strip.capitalize : "Sin nombre",
                      :accepting_emails => true,
                      :terms_of_service => "1")
      user.networks = [network]
      password = Devise.friendly_token[0,20]
      user.password = password
      user.confirmed_at = DateTime.now
      user.vpassword = password
      if user.save
        UserMailer.delay.new_user_by_supervisor(user, network, password)
        # UserMailer.new_user_by_supervisor(user, network, password).deliver
       
      else
        puts user.errors.full_messages
        invalid_users << user
      end
    end
    Notification.create :user => self.owner, :notificator => self, :kind => 'finished_uploading_users'
    if !invalid_users.blank?
      invalid_users_csv = export_users_to_csv(invalid_users)
      #SupervisorMailer.delay.finished_upload_users(self.owner, network.subdomain, invalid_users_csv)
      SupervisorMailer.finished_upload_users(self.owner, network.subdomain, invalid_users_csv)
    end
  end

  
end
