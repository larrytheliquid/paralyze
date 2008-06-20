module Paralyze
  module Runner
    # Influenced by MultiProcessSpecRunner in SeleniumGrid
    class MultiProcessExampleGroupRunner
      DEFAULT_MAXIMUM_PROCESSES = 1
      attr_accessor :maximum_processes, :options, :forker, :example_group_runner_file_path_partitions
      
      # TODO: Take in optional err + out StringIO paramaters
      def initialize(options, maximum_processes = DEFAULT_MAXIMUM_PROCESSES)
        parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
        parser.parse(options)
        self.options = parser.options
        self.maximum_processes = maximum_processes || DEFAULT_MAXIMUM_PROCESSES
        self.forker = Forker::ProcessForker
      end
      
      def load_files(file_paths)
        self.example_group_runner_file_path_partitions = []        
        file_paths.partition_balanced( concurrent_processes(file_paths.size) ).each do |file_path_partition|
          self.example_group_runner_file_path_partitions << file_path_partition
        end
      end
    
      def run
        # enumerate through all example_group_runner_file_path_partitions
        # test with mock forker
        # fork child_runners and run them
        # reduce success variable
        options.run_examples
      end
      
      def child_runner(pid, file_paths)
        child_runner_options = self.options
        child_runner = Spec::Runner::ExampleGroupRunner.new(child_runner_options)
        child_runner.load_files file_paths
        child_runner
      end
      
      def child_output_path(pid, output_path = nil)        
        output_path ? "#{output_path}.#{pid}.paralyze" : "#{pid}.paralyze"
      end
      
      def concurrent_processes(number_of_files)
        [maximum_processes, number_of_files].min
      end
      
      def fork
        forker.fork { yield }
      end
    end
  end
end
