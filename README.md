# opt-alg-framework (Optimization Algorithm Framework)

**opt-alg-framework** is a framework to work with and build optimization algorithm. The basic idea is: you will have a codificated problem with a method to calculate its fitness, an algorithm to improve this fitness and operators used with the algorithm to build new solutions.

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

    $ bundle install

Or install it yourself as:

    $ gem install opt_alg_framework

## Usage

Example: Read two instances of FSP problem (about the instances format, read README in *problem* directory!) and get its best results with SimulatedAnnealing algorithm, using RandomSwap operator.

```ruby
operator = Operator::Tweak::RandomSwap.new
problem = Problem::FSP.new
problem.load_schedule("path to instance file")
algorithm = Algorithm::LocalSearch::SimulatedAnnealing.new max_iterations: 10,
                                                           cooling_rate: 0.009,
                                                           problem: problem,
                                                           tweak_operator: operator

puts algorithm.start # It will return a hash with the best solution found and its fitness
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` or, alternatively, `bundle console` for an interactive prompt that will allow you to experiment.

## Contributing

**This gem can deal with a lot of stuff, and everything must be simple to use (a.k.a *generic*). Before start to code, take a look in the README inside the folder of what you want to code (algorithms, problems, etc), some tips of what your class should have are there. Sugestions are welcome too! (;** 

1. Fork it ( https://github.com/[my-github-username]/opt_alg_framework/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
