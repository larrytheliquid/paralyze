module Paralyze
  module Runner
    # Influenced by MultiProcessSpecRunner in SeleniumGrid
    class MultiProcessExampleGroupRunner
      DEFAULT_MAXIMUM_PROCESSES = 1
      attr_accessor :maximum_processes, :options, :forker
      
      # TODO: Take in optional err + out StringIO paramaters
      def initialize(options, maximum_processes = DEFAULT_MAXIMUM_PROCESSES)
        parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
        parser.parse(options)
        self.options = parser.options
        self.maximum_processes = maximum_processes || DEFAULT_MAXIMUM_PROCESSES
        self.forker = Forker::ProcessForker
      end
    
      def run
        options.run_examples
      end
      
      def fork
        forker.fork { yield }
      end
      
      def child_runner(pid, output_paths)
        
      end
      
      def child_output_path(pid, output_path = nil)        
        output_path ? "#{output_path}.#{pid}.paralyze" : "#{pid}.paralyze"
      end
      
      def concurrent_processes
        [maximum_processes, spec_file_paths.size].min
      end
    
      def spec_file_paths
        options.files_to_load
      end
    end
  end
end
