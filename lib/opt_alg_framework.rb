require 'opt_alg_framework/algorithm/algorithm_interface'
require 'opt_alg_framework/problem/problem_interface'
require 'opt_alg_framework/operator/tweak/tweak_interface'
require 'opt_alg_framework/operator/selector/selector_interface'
require 'opt_alg_framework/operator/crossover/permutation/permutation_crossover_interface'

Dir[File.dirname(__FILE__) + "/opt_alg_framework/problem/**/*.rb"].each { |f| require f }
Dir[File.dirname(__FILE__) + "/opt_alg_framework/operator/**/*.rb"].each { |f| require f }
Dir[File.dirname(__FILE__) + "/opt_alg_framework/algorithm/**/*.rb"].each { |f| require f }

#valid_files = Dir["#{File.dirname(__FILE__)}/**/*.rb"].reject {|f| File.directory?(f) }
#valid_files.each { |f| require f }

module OptAlgFramework

end
