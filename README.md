# OptAlgFramework

Opt-Alg-Framework is a framework to work and build optimization algorithm. The basic idea is: you will have a codificated problem with a method to calculate its fitnes, an algorithm to improve the this fitness and operators used with the algorithm to build new solutions.

What is already implemented:

  * Problems:
    * Flow Shop Permutation

  * Algorithms:
    * Local Searches:
      * Hill-Climbing
      * Simulated Annealing
      * Tabu Search

  * Operators
    * Crossover:
      * Two Point Crossover (permutational)
    * Selector:
      * Tournament Selection
    * Tweak:
      * Random Swap

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opt_alg_framework'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opt_alg_framework

## Usage

Example: read two instances of FSP problem (about the instances format, read README in *problem* directory!) and get its best results with Simulated Annealing algorithm, using RandomSwap operator.

```ruby
operator = Operator::Tweak::RandomSwap.new
problem = Problem::FSP.new
problem.load_schedule(path)
algorithm = Algorithm::LocalSearch::SimulatedAnnealing.new max_iterations: 10,
                                                           cooling_rate: 0.009,
                                                           problem: problem,
                                                           tweak_operator: operator

puts algorithm.start[:fitness]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

####Some conventions must be followed:

  * All problem classes need to have its fitness method acessible with the name *fitness*;
  * All swap operator classes need to have its swap method acessible with the name *tweak*;
  * All crossover operator classes need to have its crossover method named *cross*;
  * All selector operator classes need to have its selection method names *select*;
  * All algorithm classes need to have its main method names *start*;
  * In the algorithms, a solution is represent with a hash structure, and it's mandatory have at least the pair key-value *:solution* with the representation of the solution and *:fitness* with the fitness of the solution.

####TODO:

   * Treatments to verify if the conventions are being followed;
   * General implementations, like:
     * Local search algorithms;
     * Population based algorithms;
     * Operators (crossover, swap, selector) to any type of problem (permutational, binary, etc);
     * Different type of problems.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/opt_alg_framework/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
