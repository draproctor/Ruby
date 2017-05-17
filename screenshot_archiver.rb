# Organize all screenshots into folders
require 'fileutils'

@username = ENV['USER']

# Created an archived screenshots folder
def archive_dir?
  archive_folder = '/Users/#{@username}/Documents/Archived Screenshots'
  Dir.mkdir(archive_folder) unless Dir.exist?(archive_folder)
  return archive_folder
end

# for each item in the screenshot dir, move to archived screenshots dir
def move_captures
  scrn_dir = '/Users/#{@username}/Desktop'
  contents = Dir.entries(scrn_dir)
  contents.each do |file|
    if (File.extname(file).include? ".png") && (file.include? "Screen Shot")
      file_src = "#{scrn_dir}/#{file}"
      puts 'Moving #{file} to archived captures.'
      FileUtils.mv(file_src, archive_dir?())
    end
  end
end

archive_dir?()
move_captures()
