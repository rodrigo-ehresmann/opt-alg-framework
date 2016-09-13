require 'spec_helper'

describe Operator::Selector::TournamentSelection do
  context "when try to instantiate" do
    it "should not raise interface error" do
      expect{ Operator::Selector::TournamentSelection.new(5) }.not_to raise_error
    end
  end

  describe "#select" do
    subject { Operator::Selector::TournamentSelection.new(5) }
    let(:population) { [{ fitness: 15 }, {fitness: 13}, {fitness: 14}] }
    let(:selected) { subject.select(population) }
    #let(:new_solution) { subject.cross(solution1, solution2) }

    it "must return an individual" do
      expect(selected).to be_truthy
    end

    it "the individual cannot be the largest fitness in population" do
      expect(selected[:fitness] != population.map { |i| i[:fitness] }.max).to be_truthy
    end
  end
end
