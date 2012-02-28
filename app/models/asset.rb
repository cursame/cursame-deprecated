class Asset < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  mount_uploader :file, AssetUploader

  def self.import_csv(id, role = 'teacher', network_id)
    find(id).import_users(role, network_id)
  end

  def import_users(role, network_id)
    invalid_users = []
    network = Network.find network_id

    debugger
    CSV.open(file.url, "r").each do |row|
      u = User.new(:email => row[2],
                   :password => "cursame2012",
                   :password_confirmation => "cursame2012", 
                   :role => role, 
                   :state => "active", 
                   :first_name => row[0].strip.capitalize, 
                   :last_name => row[1].strip.capitalize)
      u.networks = [network]
      if u.valid?
        u.save
        u.password = u.first_name.gsub(" ", "_").downcase + u.id.to_s
        u.password_confirmation = u.first_name.gsub(" ", "_").downcase + u.id.to_s
        u.save
        u.confirm!
      else
        invalid_users << u
      end

    end

  end

  
end
