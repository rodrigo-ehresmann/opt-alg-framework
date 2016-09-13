module Algorithm
  module LocalSearch
    class TabuSearch
      implements AlgorithmInterface

      # Initialize specifying as parameters the tabu list size (@list_max_size), number of tweaks in each
      # current solution (@tweak_number), number of iteratiions to perform in the algorithm (@iterations)
      # and an instantiated problem and tweak operator class.
      def initialize(params)
        @tabu_list = []
        @list_max_size = params[:list_max_size]
        @tweak_number = params[:tweak_number]
        @iterations = params[:iterations]
        @tweak_operator = params[:tweak_operator]
        @problem = params[:problem]
      end

      # Main method.
      def start
        solution_c = encapsulate_solution(@problem.default_solution.dup)
        solution_s = solution_c.dup
        @tabu_list << solution_c[:solution]
        @iterations.times do
          @tabu_list.shift if @tabu_list.size == @list_max_size
          solution_bn = solution_n1 = encapsulate_solution(@tweak_operator.tweak(solution_c[:solution]))
          (@tweak_number - 1).times do
            solution_n2 = encapsulate_solution(@tweak_operator.tweak(solution_c[:solution]))
            solution_bn = solution_n2.dup if !@tabu_list.include?(solution_n2) &&
                          solution_n2[:fitness] < solution_n1[:fitness] ||
                          @tabu_list.include?(solution_n1[:solution])
          end
          if !@tabu_list.include?(solution_bn[:solution])
            solution_c = solution_bn.dup
            @tabu_list << solution_n1
          end
          solution_s = solution_c.dup if solution_c[:fitness] < solution_s[:fitness]
        end
        solution_s
      end

      # A solution is a hash, with the keys :solution and :fitness.
      def encapsulate_solution(solution)
        hash = Hash.new
        hash[:solution] = solution
        hash[:fitness] = @problem.fitness(solution)
        hash
      end
    end
  end
end
