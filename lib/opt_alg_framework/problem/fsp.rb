module Problem

  # FSP class have a inner class Schedule
  class FSP
      # Inner class who represents the production schedule, that is, a matrix were the rows are the tasks
      # and the columns the machines.
      class Schedule
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
      @@bigger = Proc.new do |a, b|
        a ||= b ||= 0
        if a > b ||= 0 then a else b end
      end

      # Initialize the FSP problem with a empty schedule
      def initialize
        @schedule = Schedule.new()
      end

      # Load the production schedule from a file
      def load_schedule(path, transpose = false)
        @schedule.build_from_file(path, transpose)
        @default_solution = (0...@schedule.schedule.row_size).to_a
      end

      # Fitness function. The hash options are:
      # - schedule: matrix of the production schedule;
      # - task: task index;
      # - machine: machine index;
      # - memory: store the total time spent at the point where the task index X is processed at the machine index Y
      #   (that avoid desnecessary recursive calls);
      # - tasks_sequence: sequence of tasks used to reorganize the schedule after calculate its makespan.
      # The default use of the method is: inform the tasks sequence as parameter and the method do all the work,
      # returning the makespan as result.
      def makespan(options = {}, block = @@bigger)
        if options[:tasks_sequence]
          schedule = @schedule.reorder_schedule(options[:tasks_sequence])
          makespan({schedule: schedule, task: schedule.row_size - 1, machine: schedule.column_size - 1, memory: {}}, block)
        else
          schedule = options[:schedule]
          task = options[:task]
          machine = options[:machine]
          memory = options[:memory]
          key = "#{task},#{machine}"
          time = schedule[task, machine]
          if task == 0 && machine == 0
            return time
          end
          if task > 0 # Before everithing, calculate the time spent in the tasks from N to 0
            time_task_before = memory["#{task - 1},#{machine}"]
            time_task_before = makespan({schedule: schedule, task: task - 1, machine: machine, memory: memory}, block) if memory["#{task - 1},#{machine}"].nil?
          end
          if machine > 0 # Calculate the time spent  at the machines from N to 0
            time_machine_before = memory["#{task},#{machine - 1}"]
            time_machine_before = makespan({schedule: schedule, task: task, machine: machine - 1, memory: memory}, block) if memory["#{task},#{machine - 1}"].nil?
          end
          total_time = block.call(time_task_before, time_machine_before) + time # Calculate the total time
          memory[key] = total_time # Store the total time
          total_time
        end
      end
      alias :fitness :makespan # Needed because, in the algorithm classes, to be generic we call  the 'fitness' function (all problem classes need to have a 'fitness' function)
  end
end
