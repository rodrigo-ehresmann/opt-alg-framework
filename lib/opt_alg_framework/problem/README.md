# About the instaces of the problems

## FSP (Flow Shop Permutation)
The instance of this kind of problem is a matrix, specifically a matrix where the rows are the tasks and machines are the columns. The fitness method need that to work properly.

However, normally the instances available to download are an inverted matrix, where the rows are machines and tasks the columns. So, when loaded the instance file to a *schedule*, matrix *transpose* method is called, inverting the matrix to the correct format.

Having that in mind, a valid instance example is shown bellow, with 3 machines (lines) and 5 tasks (columns):

> 23 12 56 22 11
> 65 25 32 21 9
> 12 45 17 33 10
