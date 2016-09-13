# Implementation Details

  * Inside your class, use `implements ProblemInterface`. That provides an interface behavior, enforcing
  the implementation of mandatory methods;
  * Organize algorithm class inside modules (e.g., `FSP` class);
  * `initialize` have no arguments;
  * Make sure that you have `attr_reader :default_solution` in your class and fill this instance variable with an initial solution. This variable will be called inside algorithm classes.  

# About the problem instances

## FSP (Flow Shop Permutation)
The instance of this kind of problem is a matrix, specifically a matrix where the rows are tasks and columns are machines. This order need to be preserved to the fitness method work properly.

A valid instance example is shown bellow, with 5 tasks (lines) and 3 machines (columns):

> 12 65 23 <br>
> 45 25 12 <br>
> 17 32 56 <br>
> 33 21 22 <br>
> 10 9 11 <br>

However, if your instance file is an inverted matrix (rows are machines and columns are tasks), just pass *true* in a block to transpose the matrix.

```ruby
fsp.load_schedule(path_to_instance) { true }
```
