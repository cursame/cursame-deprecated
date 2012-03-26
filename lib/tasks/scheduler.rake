desc "This task is called by the Heroku scheduler add-on"
task :publish_assignments => :environment do
    puts "Publishing new assignments"
    Assignment.publish_new_assignments
    puts "done."
end
