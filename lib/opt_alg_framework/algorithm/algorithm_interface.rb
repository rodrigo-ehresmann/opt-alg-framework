require 'interface'

module AlgorithmInterface
  include Interface

  def initialize(params = {})
    must_implement start: 0
    super(params)
  end
end
