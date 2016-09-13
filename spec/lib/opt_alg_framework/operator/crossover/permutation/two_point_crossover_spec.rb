require 'spec_helper'

describe Operator::Crossover::Permutation::TwoPointCrossover do
  context "when try to instantiate" do
    it "should not raise interface error" do
      expect{ Operator::Crossover::Permutation::TwoPointCrossover.new }.not_to raise_error
    end
  end

  describe "#cross" do
    subject { Operator::Crossover::Permutation::TwoPointCrossover.new }
    let(:solution1) { (1..20).to_a }
    let(:solution2) { 20.downto(1).to_a }
    let(:new_solution) { subject.cross(solution1, solution2) }

    it "must display a different solution" do
      expect(new_solution).not_to eq(solution1)
      expect(new_solution).not_to eq(solution2)
    end

    it "must display a solution with the same length" do
      expect(solution1.length == new_solution.length).to be_truthy
      expect(solution2.length == new_solution.length).to be_truthy
    end

    it "must display the same solution pieces" do
      expect(solution1 - new_solution).to eq([])
      expect(solution2 - new_solution).to eq([])
    end
  end
end
