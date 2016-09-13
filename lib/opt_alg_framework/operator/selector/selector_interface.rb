require 'interface'

module SelectorInterface
  include Interface

  def initialize(param)
    must_implement select:1
    super(param)
  end
end
