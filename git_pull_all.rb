# git pull on each git repo directory

require 'colorize'

# Add additional repos as needed.
repos = [
  '~/GitHub/powershell',
  '~/GitHub/bash',
  '~/GitHub/Ruby',
  '~/GitHub/Collab_klborders/Ruby',
]

repos.each do |r|
  begin
    puts "Pulling the #{r} repo...\n".green
    system( "cd #{r} && git pull origin master" )
  rescue
    puts "Failed to pull #{r}.".red
  end
end
