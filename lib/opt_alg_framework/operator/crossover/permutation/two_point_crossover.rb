module Operator
  module Crossover
    module Permutation
      class TwoPointCrossover
        implements CrossoverInterface

        # Main method.
        def cross(chromossome1, chromossome2)
          point1 = Random.rand(0..chromossome1.size - 1)
          point2 = Random.rand(point1..chromossome1.size - 1)
          start_piece = Array.new
          middle_piece = Array.new
          end_piece = Array.new

          point1.upto(point2) do |i| # Get the middle of the chromossome1, between the two points
            middle_piece << chromossome1[i]
          end
          # After the tasks of the middle are choosed, there is no need of them in the chromossomes anymore
          chromossome1 -= middle_piece
          chromossome2 -= middle_piece
          chromossome2.size.times do |i| # Loop to check the order of the remaining genes in the chromossome2
            if start_piece.size <= point1 # Check if the chromossomes will be placed before or after the "middle" point
              start_piece << chromossome1[i]
            else
              end_piece << chromossome1[i]
            end
          end
          start_piece + middle_piece + end_piece
        end
      end

    end
  end
end
