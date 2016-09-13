require 'spec_helper'

describe Algorithm::LocalSearch::HillClimbing.new do
  describe "#start" do
    before(:all) do
      problem = Problem::FSP.new
      problem.load_instance("#{Dir.pwd}/spec/instances/fsp/2x5.txt")
      params = { problem: problem,
                 tweak_operator: Operator::Tweak::RandomSwap.new }
      @algorithm = Algorithm::LocalSearch::HillClimbing.new(params)
    end

    context "when "
  end
end
