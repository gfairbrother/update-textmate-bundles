# lib = File.dirname(__FILE__) + '/'
# 
# require lib + 'foo.rb'
# require lib + 'bar.rb'

puts "Updating git based TextMate Bundles for: #{`whoami`}\n"

# first change to the current users home dir
# note: If a block is given, it is passed the name of the new current directory, and the block is executed with that as the current directory. The original working directory is restored when the block exits.
Dir.chdir() do
  Dir.chdir("Library/Application\ Support/TextMate/Bundles/") do
    puts "Changed directory to #{Dir.pwd}\n"
    current_dir = Dir.new(".")
    current_dir.each  do |file|
      #check to see if it's a dir containing a git repo
      if test(?d, "#{file}/.git")
        puts "#{file} is a git repo, updating..."
        Dir.chdir(file) do
          system("git pull")
        end
      end
    end
  end
end
 
puts "\nDone!\nAll bundles updated."