# Organize all screenshots into folders
require 'fileutils'
require 'time'

@username = ENV['USER']

# Created an archived screenshots folder
def archive_dir
  archive_folder = "/Users/#{@username}/Documents/Archived Screenshots"
  Dir.mkdir(archive_folder) unless Dir.exist?(archive_folder)
  return archive_folder
end

# Organize all screenshots into folders for a specific day
def sub_dir(ad)
  time = Time.now
  dir_name = "Archive #{time.month}-#{time.day}-#{time.year}"
  sub_dir_name = "#{ad}/#{dir_name}"

  Dir.mkdir(sub_dir_name) unless Dir.exist?(sub_dir_name)
  return sub_dir_name
end

# for each item in the screenshot dir, move to archived screenshots dir
def move_captures
  iterations = 0
  scrn_dir = "/Users/#{@username}/Desktop"
  contents = Dir.entries(scrn_dir)

  contents.each do |file|
    if (File.extname(file).include? ".png") && (file.include? "Screen Shot")
      file_src = "#{scrn_dir}/#{file}"
      puts "Moving #{file} to archived captures."
      FileUtils.mv(file_src, sub_dir())
      iterations += 1
    end
  end
  return iterations
end

def mk_log(mc)
  log_t = Time.now
  log_name = "#{log_t.month}/#{log_t.day}/#{log_t.year} at #{log_t.hour}:00"
  log_dir = "#{archive_dir()}/.archive_logs"
  Dir.mkdir(log_dir) unless Dir.exist?(log_dir)

  log_file = "#{log_dir}/Archive Log.txt"
  File.new(log_file, "w+") unless File.exist?(log_file)
  File.open(log_file, "a") do |line|
    line.puts "Moved #{mc} items on #{log_name}"
  end
end

sub_dir(archive_dir())
mk_log(move_captures())
