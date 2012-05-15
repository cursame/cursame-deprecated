desc "This task updates the start_at field on surveys and assignments"
task :update_start_at_fields => :environment do
    puts "Set all Assignments to published and set initial start_at to avoid future problems"
    Assignment.update_all(:state => "published")
    Assignment.update_all(:start_at => DateTime.now)
    puts "done with assignments."
    
    puts "Set the initial start_at on all Surveys"
    Survey.published.update_all(:start_at => DateTime.now)
    Survey.unpublished.update_all(:start_at => DateTime.now+1.month)
    puts "done with surveys."
end
