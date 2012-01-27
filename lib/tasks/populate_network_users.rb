require 'csv'

desc "Populates the database with the CSV file specified"

task :populate_network_users => :environment do

User.create!(:email => "webmaster@cursa.me",
             :password => "cursameinnkuproduccion",
             :password_confirmation => "cursameinnkuproduccion", 
             :role => "supervisor", 
             :state => "active", 
             :first_name => "Cursame", 
             :last_name => "Admin")
end

