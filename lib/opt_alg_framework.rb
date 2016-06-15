valid_files = Dir["#{File.dirname(__FILE__)}/**/*"].reject {|f| File.directory?(f) }
valid_files.each { |f| require f }

module OptAlgFramework
  # Write your code here
end
