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
        partition_balanced( concurrent_processes(file_paths.size), file_paths ).each do |file_path_partition|
          self.example_group_runner_file_path_partitions << file_path_partition
        end
      end
    
      def run
        options.run_examples
      end
      
      def child_runner(pid, file_paths)
        # Spec::Runner::ExampleGroupRunner.new(self.options)
      end
      
      def child_output_path(pid, output_path = nil)        
        output_path ? "#{output_path}.#{pid}.paralyze" : "#{pid}.paralyze"
      end
      
      def partition_balanced(number_of_splits, array)    
        # TODO: Refactor this inefficient gremlin mercilessly
        partitions = (1..number_of_splits).map { [] }
        non_destructive_clone = array.clone
        until non_destructive_clone.empty? do
          partitions.each do |partition|
            partition << non_destructive_clone.shift unless non_destructive_clone.empty?
          end
        end
        index = 0
        partitions.map do |partition| 
          current_index = index
          index += partition.size
          array[current_index...(partition.size + current_index)] 
        end
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
