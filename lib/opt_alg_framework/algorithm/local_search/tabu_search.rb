module Algorithm
  module LocalSearch
    class TabuSearch

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
        s = encapsulate_solution(@problem.default_solution.dup)
        best = s.dup
        @tabu_list << s[:solution]
        @iterations.times do
          @tabu_list.shift if @tabu_list.size == @list_max_size
          r = encapsulate_solution(@tweak_operator.tweak(s[:solution]))
          (@tweak_number - 1).times do
            w = encapsulate_solution(@tweak_operator.tweak(s[:solution]))
            r = w.dup if !@tabu_list.include?(w) && w[:fitness] < r[:fitness] || @tabu_list.include?(r[:solution])
          end
          if !@tabu_list.include?(r[:solution])
            s = r.dup
            @tabu_list << r
          end
          best = s.dup if s[:fitness] < best[:fitness]
        end
        best
      end

      # A solution is a hash, with the keys :solution and :fitness.
      def encapsulate_solution(solution)
        hash = Hash.new
        hash[:solution] = solution
        hash[:fitness] = @problem.fitness(tasks_sequence: solution)
        hash
      end
    end
  end
end
