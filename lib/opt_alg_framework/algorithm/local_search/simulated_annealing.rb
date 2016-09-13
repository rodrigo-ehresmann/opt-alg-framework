module Algorithm
  module LocalSearch
    class SimulatedAnnealing
      include AlgorithmInterface
      include Math

      # Initialize specifying the cooling rate percentage (@cooling_rate), number of iterations in each
      # temperature (@max_iterations) and passing an instantiated problem and tweak operator class.
      def initialize(params)
        @cooling_rate = params[:cooling_rate]
        @problem = params[:problem]
        @tweak_operator = params[:tweak_operator]
        @max_iterations = params[:max_iterations]
        @temperature = initial_temperature
      end

      # solution_b = best solution
      # solution_n = neighbor solution
      # solution_c = current solution
      def start
        solution_b = encapsulate_solution(@problem.default_solution.shuffle)
        solution_c = solution_b.dup
        temperature = @temperature
        while temperature > 1 do
          iteration = 1
          while iteration < @max_iterations do
            solution_n = encapsulate_solution(@tweak_operator.tweak(solution_c[:solution]))
            solution_c = solution_n.dup if accept?(solution_c[:fitness], solution_n[:fitness], temperature)
            solution_b = solution_c.dup if solution_c[:fitness] < solution_b[:fitness]
            iteration += 1
          end
          temperature *= 1 - @cooling_rate
        end
        solution_b
      end

      private

      # Calculate the initial temperature, generating N neighbors of an initial solution and
      # setting as initial temperature the neighbor with the worst fitness.
      def initial_temperature
        solution = encapsulate_solution(@problem.default_solution.shuffle)
        max = solution
        @max_iterations.times do
          neighbor = encapsulate_solution(@tweak_operator.tweak(solution[:solution]))
          max = neighbor if neighbor[:fitness] > max[:fitness]
        end
        max[:fitness]
      end

      # A solution is a hash, with the keys :solution and :fitness.
      def encapsulate_solution(solution)
        hash = Hash.new
        hash[:solution] = solution
        hash[:fitness] = @problem.fitness(solution)
        hash
      end

      # Calculate the acceptance probability, if and only if the neighbor fitness is worst than
      # the current fitness.
      def accept?(fitness, neighbor_fitness, temperature)
        return true if neighbor_fitness < fitness
        probability = E ** - ((fitness - neighbor_fitness).abs.fdiv(temperature)) # E is the Euller number
        r = Random.rand(0.0..1)
        if r < probability
          return true
        else
          false
        end
      end
    end
  end
end
