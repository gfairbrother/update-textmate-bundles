#lib = File.dirname(__FILE__) + '/'
# require lib + 'foo.rb'
# require lib + 'bar.rb'

puts "Updating TextMate Bundles for: #{`whoami`}\n"

# first change to the current users home dir
# note: If a block is given, it is passed the name of the new current directory, and the block is executed with that as the current directory. The original working directory is restored when the block exits.

# Array of directories you wish to ignore.. i.e. parent, and current.
ignore = ['.','..']

Dir.chdir() do
  Dir.chdir("Library/Application\ Support/TextMate/Bundles/") do
    puts "Changed directory to #{Dir.pwd}\n"
    puts "Updating bundles\n"
    current_dir = Dir.new(".")
    current_dir.each  do |dir|
      # Only go through directories and ignore directories specified by user.
      unless File.ftype(dir) != "directory" or ignore.include?(dir)
        if test(?d, "#{dir}/.git")
          puts "#{dir} is a git repo, updating..."
          Dir.chdir(dir) do
            system("git pull")
          end
        elsif test(?d, "#{dir}/.svn")
          puts "#{dir} is a svn repo, updating..."
          Dir.chdir(dir) do
            system("svn up")
          end
          puts "you should check to see if there is a git based version of this repo at:\nhttp://github.com/textmate"
        else
          puts "################################################################################"
          puts "#{dir} does not seem to be under version control\nYou should check to see if there is a git version here:\nhttp://github.com/textmate"
          puts "################################################################################"
        end
      end
    end
  end
end

puts "\nreloading bundles"
system("osascript -e 'tell app \"TextMate\" to reload bundles'")
puts "\nDone!\nAll bundles updated."
