require 'spec_helper'

describe Operator::Tweak::RandomSwap do
  context "when try to instantiate" do
    it "should not raise interface error" do
      expect{ Operator::Tweak::RandomSwap.new }.not_to raise_error
    end
  end

  describe "#tweak" do
    subject { Operator::Tweak::RandomSwap.new }
    let(:solution) { (1..20).to_a }
    let(:new_solution) { subject.tweak(solution) }

    it "must display a different solution" do
      expect(new_solution).not_to eq(solution)
    end

    it "must display a solution with the same length" do
      expect(solution.length == new_solution.length).to be_truthy
    end

    it "must display the same solution pieces" do
      expect(solution - new_solution).to eq([])
    end
  end
end
