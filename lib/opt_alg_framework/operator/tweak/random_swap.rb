module Operator
  module Tweak

    class RandomSwap
      # Main method.
      def tweak(solution)
        copy = solution.dup
        piece1 = Random.rand(0...copy.size)
        piece2 = Random.rand(0...copy.size)
        x = copy[piece1]
        copy[piece1] = copy[piece2]
        copy[piece2] = x
        copy
      end
    end

  end
end
