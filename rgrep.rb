#!/usr/bin/env ruby
# args = ARGF.argv
args = ARGV

# Check if the correct number of arguments is provided
if ARGV.length < 2
    puts "Usage: #{$0} REGEXP FILE..."
    exit 1
  end
  
  # Parse the regular expression and the list of files
  regexp = Regexp.new(ARGV.shift)
  files = ARGV
  
  # Search each file for lines matching the regular expression
  files.each do |filename|
    begin
      File.foreach(filename).with_index(1) do |line, lineno|
        puts "#{filename}:#{lineno}:#{line}" if line.match?(regexp)
      end
    rescue Errno::ENOENT
      puts "rgrep: #{filename}: No such file or directory"
    rescue => e
      puts "rgrep: #{filename}: #{e.message}"
    end
  end
  