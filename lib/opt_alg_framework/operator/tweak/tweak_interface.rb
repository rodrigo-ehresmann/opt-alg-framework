require 'interface'

module TweakInterface
  include Interface

  def initialize
    must_implement tweak:1
    super
  end
end
