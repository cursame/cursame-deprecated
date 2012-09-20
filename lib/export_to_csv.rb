module ExportToCsv
  
  def export_users_to_csv(users)
    csv_string = CSV.generate do |csv|
      csv << ["first name", "last name", "email","vpassword"]
      users.each do |user|
        csv << [user.first_name, user.last_name, user.email,user.vpassword]
      end
    end
    csv_string
  end

end
