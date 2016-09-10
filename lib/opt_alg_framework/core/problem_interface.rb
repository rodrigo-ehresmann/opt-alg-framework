require 'interface'

module ProblemInterface
  include Interface

  def initialize
    must_implement load_instance: 1, fitness: 1
    super
  end
end
