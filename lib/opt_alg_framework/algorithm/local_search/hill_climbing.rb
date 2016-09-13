module Algorithm
  module LocalSearch
    class HillClimbing
      implements AlgorithmInterface

      # Initialize passing a instantiated class of a problem and tweak operator
      def initialize(params)
        @tweak_operator = params[:tweak_operator]
        @problem = params[:problem]
      end

      # solution_b = best solution
      # solution_n = neighbor solution
      def start
        solution_b = encapsulate_solution(@problem.default_solution.shuffle)
        while true do
          solution_n = encapsulate_solution(@tweak_operator.tweak(solution_b[:solution]))
          if solution_n[:fitness] < solution_b[:fitness]
            solution_b = solution_n.dup
          else
            break
          end
        end
        solution_b
      end

      # Solution is a hash, with the keys :solution and :fitness
      def encapsulate_solution(solution)
        hash = Hash.new
        hash[:solution] = solution
        hash[:fitness] = @problem.fitness(solution)
        hash
      end
    end
  end
end
