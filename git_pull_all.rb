# Git pull on each git repo directory

# Add additional repos as needed.
repos = [
  '~/GitHub/powershell',
  '~/GitHub/bash',
  '~/GitHub/Ruby'
]

repos.each do |r|
  Dir.chdir("#{r}") do
    begin
      puts "Pulling the #{r} repo...\n"
      system( "git pull origin master" )
    rescue
      puts "Failed to pull #{r}."
    end
  end
end