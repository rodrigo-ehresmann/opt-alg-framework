module Algorithm
  module LocalSearch
    class HillClimbing
      # Initialize passing a instantiated class of a problem and tweak operator
      def initialize(params)
        @tweak_operator = params[:tweak_operator]
        @problem = params[:problem]
      end

      # Main method
      def start
        best = encapsulate_solution(@problem.default_solution)
        while true do
          r = encapsulate_solution(@tweak_operator.tweak(best[:solution]))
          if r[:fitness] < best[:fitness]
            best = r.dup
          else
            break
          end
        end
        best
      end

      # Solution is a hash, with the keys :solution and :fitness
      def encapsulate_solution(solution)
        hash = Hash.new
        hash[:solution] = solution
        hash[:fitness] = @problem.fitness(tasks_sequence: solution)
        hash
      end

    end
  end
end
