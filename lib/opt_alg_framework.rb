pwd = Dir.getwd
dir_basename = File.basename(pwd) 
valid_files = Dir["#{pwd}/lib/#{dir_basename}/**/*"].reject {|f| File.directory?(f) }
valid_files.each { |f| require f }

module OptAlgFramework
  # Write your code here
end
