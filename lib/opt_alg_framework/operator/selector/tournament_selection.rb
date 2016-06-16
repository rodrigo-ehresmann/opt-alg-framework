module Operator
  module Selector

    class TournamentSelection
      # Initialize informing the tournament size.
      def initialize(size)
        @size = size
      end

      # Main method.
      def select(population)
        best_individual = population[Random.rand(0...population.size)]
        0.upto(@size) do
          individual = population[Random.rand(0...population.size)]
          best_individual = individual if individual[:fitness] < best_individual[:fitness]
        end
        best_individual
      end
    end

  end
end
