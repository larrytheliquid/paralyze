module Paralyze
  module Runner
    class MultiProcessExampleGroupRunner < Spec::Runner::ExampleGroupRunner
      DEFAULT_MAXIMUM_PROCESSES = 1
      attr_reader   :partitioned_example_groups      
      attr_accessor :maximum_processes, :forker
      
      def initialize(options, maximum_processes = DEFAULT_MAXIMUM_PROCESSES)
        super(options)
        self.maximum_processes = maximum_processes || DEFAULT_MAXIMUM_PROCESSES
        self.forker = Forker::ProcessForker
      end
      
      def load_files(file_paths)
        super(file_paths)
        @partitioned_example_groups = @options.example_groups.partition_balanced( concurrent_processes(@options.example_groups.size) )
      end
    
      def run
        # enumerate through all example_group_runner_file_path_partitions
        # test with mock forker
        # fork child_runners and run them
        # reduce success variable
        @options.run_examples
      end
      
      def child_output_path(pid, output_path = nil)        
        output_path ? "#{output_path}.#{pid}.paralyze" : "#{pid}.paralyze"
      end
      
      def concurrent_processes(number_of_files)
        [maximum_processes.to_i, number_of_files].min
      end
      
      def fork
        forker.fork { yield }
      end
    end
  end
end
