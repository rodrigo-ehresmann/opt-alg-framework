module Problem
  #require 'opt_alg_framework/problem/problem_interface'
  # FSP class have a inner class Schedule
  class FSP
    implements ProblemInterface

      # Inner class who represents the production schedule, that is, a matrix
      # were the rows are the tasks and the columns the machines.
      class Production
        require 'matrix'

        attr_reader :schedule

        # Fill the schedule reading the an instance from a file
        def build_from_file(path, transpose)
          rows = Array.new
          File.foreach(path).each do |line|
            rows << line.split(" ").collect{ |e| e.to_i }
          end
          @schedule = transpose ? Matrix.rows(rows).transpose : Matrix.rows(rows)
        end

        # Given a sequence of tasks, reorder the schedule in this sequence
        def reorder_schedule(tasks_sequence)
          rows = Array.new
          tasks_sequence.each do |task|
            rows << @schedule.row(task)
          end
          Matrix.rows(rows)
        end
      end

    attr_reader :default_solution # Is the sequence of tasks ordered from 0...N

    # Used in makespan function to compare two execution times (also if one of them or the two are blank)

    # Initialize the FSP problem with a empty schedule
    def initialize
      @production = Production.new
    end

    # Load the production schedule from a file
    def load_instance(path)
      transpose = block_given? ? yield : false
      @production.build_from_file(path, transpose)
      @default_solution = (0...@production.schedule.row_size).to_a
    end

    def fitness(solution)
      schedule = @production.reorder_schedule(solution)
      makespan(schedule: schedule, task: schedule.row_size - 1,
                machine: schedule.column_size - 1, memory: {})
    end

    private

    def bigger(num1 = 0, num2 = 0)
      num1 ||= num2 ||= 0
      if num1 > num2 ||= 0 then num1 else num2 end
    end

    # The hash options are:
    # - schedule: matrix of the production schedule;
    # - task: task index;
    # - machine: machine index;
    # - memory: store the total time spent at the point where the task index X is processed at the machine index Y
    #   (that avoid desnecessary recursive calls).
    def makespan(options = {})
      schedule = options[:schedule]
      task = options[:task]
      machine = options[:machine]
      memory = options[:memory]
      key = "#{task},#{machine}"
      time = schedule[task, machine]

      return time if task == 0 && machine == 0

      if task > 0 # Before everithing, calculate the time spent in the tasks from N to 0
        time_task_before = memory["#{task - 1},#{machine}"]
        time_task_before = makespan(schedule: schedule, task: task - 1,
                           machine: machine, memory: memory) if memory["#{task - 1},#{machine}"].nil?
      end

      if machine > 0 # Calculate the time spent of the same task at the machines from N to 0
        time_machine_before = memory["#{task},#{machine - 1}"]
        time_machine_before = makespan(schedule: schedule, task: task,
                              machine: machine - 1, memory: memory) if memory["#{task},#{machine - 1}"].nil?
      end

      total_time = bigger(time_task_before, time_machine_before) + time # Calculate the total time
      memory[key] = total_time # Store the total time
      total_time
    end
  end
end
