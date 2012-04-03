desc "This task is called by the Heroku scheduler add-on"
task :move_uploads_to_correct_folders, [:arg1] => :environment do |t, args|
    puts "Updating on #{args[:arg1]}"
    puts "Moving the user avatars"
    User.all.each do |u|
      puts "Updating avatar file for user #{u.id}"
      dir = u.avatar_file.url.split("/")
      if dir.count > 3
      begin
      u.remote_avatar_file_url = args[:arg1] + "/"+dir[1]+"/"+dir.last
      rescue
      u.remove_avatar_file!
      end
      u.save!
      end
      puts "updated."
    end
    puts "done."
    
    puts "Moving the Course avatars"
    Course.all.each do |u|
      puts "Updating avatar file for course #{u.id}"
      file = u.course_logo_file.url
      if file
        dir = file.split("/")
        if dir.count > 3
          begin
          u.remote_course_logo_file_url = args[:arg1] + "/"+dir[1]+"/"+dir.last
          rescue
          u.remove_course_logo_file!
          end
          u.save!
        end
      end
      puts "updated."
    end
    puts "done."
    
    puts "Moving the Network avatars"
    Network.all.each do |u|
      puts "Updating avatar file for network #{u.id}"
      dir = u.logo_file.url
      if dir
        dir = dir.split("/")
        if dir.count > 3
        begin
        u.remote_logo_file_url = args[:arg1] + "/"+dir[1]+"/"+dir.last
        rescue
        u.remove_logo_file!
        end
        u.save!
        end
      end
      puts "updated."
    end
    puts "done."
    
    puts "Moving the Assets"
    Asset.all.each do |u|
      puts "Updating asset #{u.id}"
      dir = u.file.url
      if dir
        dir = dir.split("/")
        if dir.count > 3
          begin
            u.remote_file_url = args[:arg1] + "/"+dir[1]+"/"+dir.last
          rescue
            u.remove_file!
          end
          u.save!
        end
      end
      puts "updated."
    end
    CarrierWave.clean_cached_files!
    puts "done."
end
