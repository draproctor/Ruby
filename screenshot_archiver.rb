# Organize all screenshots into folders
require 'fileutils'
require 'time'

@username = ENV['USER']

# Log sorting is done by current time/date. Declaring this early saves space.
@t = Time.now
@archive_folder = "/Users/#{@username}/Documents/Archived Screenshots"


# Created an archived screenshots folder
def archive_dir
  archive_folder = "/Users/#{@username}/Documents/Archived Screenshots"
  Dir.mkdir(@archive_folder) unless Dir.exist?(@archive_folder)
end

# Organize all screenshots into folders for a specific day
def sub_dir
  dir_name = "Archive #{@t.month}-#{@t.day}-#{@t.year}"
  sub_dir_name = "#{@archive_folder}/#{dir_name}"

  Dir.mkdir(sub_dir_name) unless Dir.exist?(sub_dir_name)
  return sub_dir_name
end

# for each item in the screenshot dir, move to archived screenshots dir
def move_captures
  # this is for counting the number of objects moved. Starts at zero.
  iterations = 0
  # scrn_dir is the default screenshot save location on OS X.
  # This can be changed to fit your OS's default or your preferences.
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

# Make a hiddle folder for saving the archive logs and edit the log to include
# number of items moved, what day, and at what time.
def mk_log(mc)
  log_name = "#{@t.month}/#{@t.day}/#{@t.year} at #{@t.hour}:#{@t.min}"
  log_dir = "#{@archive_folder}/.archive_logs"
  Dir.mkdir(log_dir) unless Dir.exist?(log_dir)

  log_file = "#{log_dir}/Archive Log.txt"
  File.new(log_file, "w+") unless File.exist?(log_file)
  # `a` is for `append`. This appends a new line to the end of the file.
  File.open(log_file, "a") do |line|
    line.puts "Moved #{mc} items on #{log_name}"
  end
end

archive_dir()
sub_dir()
mk_log(move_captures())
