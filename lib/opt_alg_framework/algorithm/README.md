# Implementation Details

  * Inside your class, use `implements AlgorithmInterface`. That provides an interface behavior, enforcing
  the implementation of mandatory methods;
  * Organize algorithm class inside modules (e.g., `HillClimbing` class);
  * `initialize` have only a hash like argument, where the configurations used in algorithm are specifyied;
  * A solution is represented like a hash, with at least `:solution` and `:fitness` keys. The best solution should be 
  returned by the main method.
