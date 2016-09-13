require 'spec_helper'

describe Problem::FSP do
  describe "#fitness" do
    let(:problem) { Problem::FSP.new }

    context "when normal reading instances" do
      let(:instances) {
                        { "3x2" => { [0, 1] => 14 } }
                        { "3x2" => { [1, 0] => 12 } }
                        { "2x5" => { [0, 1, 2, 3, 4] => 20 } }
                        { "2x5" => { [0, 4, 2, 3, 1] => 18 } }
                      }

      it "should return the right makespan" do
        instances.each do |instance, solution|
          problem.load_instance("#{Dir.pwd}/spec/instances/fsp/#{instance}.txt")
          solution.each do |tasks_sequence, result|
            expect(problem.fitness(tasks_sequence)).to eq(result)
          end
        end
      end
    end

    context "when inform to transpose the instance after read" do
      let(:transposed_instances) {
                                    { "3x2" => { [0, 1, 2] => 14 } }
                                    { "3x2" => { [2, 1, 0] => 12 } }
                                    { "2x5" => { [0, 1] => 20 } }
                                    { "2x5" => { [1, 0] => 19 } }
                                 }

      it "should return the right makespan" do
        transposed_instances.each do |instance, solution|
          problem.load_instance("#{Dir.pwd}/spec/instances/fsp/#{instance}.txt") { true }
          solution.each do |tasks_sequence, result|
            expect(problem.fitness(tasks_sequence)).to eq(result)
          end
        end
      end
    end
  end
end
