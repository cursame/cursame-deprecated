desc "This task is called by the Heroku scheduler add-on"
task :publish_assignments => :environment do
    puts "Publishing new assignments"
    Assignment.publish_new_assignments
    puts "done."
end

task :publish_surveys => :environment do
    puts "Publishing new surveys"
    Survey.publish_new_surveys
    puts "done."
end

task :remove_temporal_carrierwave_folders do
  puts "Deleting Temporal Folders"
    path_to_be_deleted = "#{Rails.root}/tmp/cached-carrierwave"
    FileUtils.remove_dir(path_to_be_deleted, :force => true)
  puts "done."
end

#desc "This task deletes old Action rows"
#task :delete_actions => :environment do
#   puts "Deleting last month actions"
#   Action.delete_all ['created_at < ?', 1.month.ago ]
#   puts "done."
#end
