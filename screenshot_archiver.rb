# Organize all screenshots into folders
require 'fileutils'

@username = ENV['USER']

# Created an archived screenshots folder
def archive_dir?
  archive_folder = '/Users/' + @username + '/Documents/Archived Screenshots'
  unless Dir.exist?(archive_folder)
    Dir.mkdir(archive_folder)
  end
  return archive_folder
end

# for each item in the screenshot dir, move to archived screenshots dir
def move_scrnshts
  scrn_dir = '/Users/' + @username + '/Desktop'
  contents = Dir.entries(scrn_dir)
  contents.each do |file|
    if (File.extname(file).include? ".png") && (file.include? "Screen Shot")
      file_src = scrn_dir + '/' + file
      FileUtils.mv(file_src, archive_dir?())
    end
  end
end

archive_dir?()
move_scrnshts()
