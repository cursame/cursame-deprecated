require 'csv'
puts "Creando maestros"

CSV.open("ese_profesores.csv", "r").each do |row|
  first_name = "Maestro"
  last_name = "ESE"
  name = row[0].split(' ')
  if name.length == 1
    first_name = name.first.strip.capitalize
  elsif name.length == 2
    first_name = name.first.strip.capitalize
    last_name = name.last.strip.capitalize
  elsif name.length == 3
    first_name = name.first.strip.capitalize
    last_name = name[1].strip.capitalize + " " + name.last.strip.capitalize
  elsif name.length > 3
    first_name = name.first.strip.capitalize + " " + name[1].strip.capitalize
    last_name = name[name.size-2].strip.capitalize + " " + name.last.strip.capitalize
  end

  u = User.new(:email => row[1],
               :password => "cursame2012",
               :password_confirmation => "cursame2012", 
               :role => "teacher", 
               :state => "active", 
               :first_name => first_name.strip, 
               :last_name => last_name.strip)
  u.networks = [Network.find(5)]
  u.save
  u.password = u.first_name.gsub(" ", "_").downcase + u.id.to_s
  u.save
  u.confirm!

end
