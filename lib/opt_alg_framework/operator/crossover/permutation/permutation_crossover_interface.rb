require 'interface'

module PermutationCrossoverInterface
  include Interface

  def initialize
    must_implement cross:2
    super
  end
end
