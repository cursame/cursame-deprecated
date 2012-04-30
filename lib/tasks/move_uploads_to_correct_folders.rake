desc "This task is called by the Heroku scheduler add-on"
task :move_user_avatar_to_correct_folders, [:arg1] => :environment do |t, args|
  puts "Updating on #{args[:arg1]}"
  puts "Moving the user avatars"
  User.all.each do |u|
    puts "Updating avatar file for user #{u.id}"
    dir = u.avatar_file.url.split("/")
    if dir.count > 3
      dir = args[:arg1] + "/uploads/"+dir.last
      begin
        u.remote_avatar_file_url = dir
        u.save!
        puts "updated.\n\n"
      rescue Exception => e
        puts e.message
        puts dir
        puts "failed.\n\n"
      end
    end
  end
  puts "done."
end

task :move_course_avatar_to_correct_folders, [:arg1] => :environment do |t, args|
  puts "Moving the Course avatars"
  Course.all.each do |u|
    puts "Updating avatar file for course #{u.id}"
    file = u.course_logo_file.url
    if file
      dir = file.split("/")
      if dir.count > 3
        dir = args[:arg1] + "/uploads/"+dir.last
        begin
          u.remote_course_logo_file_url = dir
          u.save!
          puts "updated.\n\n"
        rescue Exception => e
          puts e.message
          puts dir
          puts "failed.\n\n"
        end
      end
    end
    puts "updated."
  end
  puts "done."
end

task :move_network_avatar_to_correct_folders, [:arg1] => :environment do |t, args|
  puts "Moving the Network avatars"
  Network.all.each do |u|
    puts "Updating avatar file for network #{u.id}"
    dir = u.logo_file.url
    if dir
      dir = dir.split("/")
      if dir.count > 3
        dir = args[:arg1] + "/uploads/"+dir.last
        begin
          u.remote_logo_file_url = dir
          u.save!
          puts "updated.\n\n"
        rescue Exception => e
          puts e.message
          puts dir
          puts "failed.\n\n"
        end
      end
    end
  end
  puts "done."
end

task :move_assets_to_correct_folders, [:arg1] => :environment do |t, args|
  puts "Moving the Assets"
  Asset.all.each do |u|
    puts "Updating asset #{u.id}"
    dir = u.file.url
    if dir
      dir = dir.split("/")
      if dir.count > 3
        dir = args[:arg1] + "/uploads/"+dir.last
        begin
          u.remote_file_url = dir
          u.save!
          puts "updated.\n\n"
        rescue Exception => e
          puts e.message
          puts dir
          puts "failed.\n\n"
        end
      end
    end
  end
  CarrierWave.clean_cached_files!
  puts "done."
end
