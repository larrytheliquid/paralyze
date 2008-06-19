require 'stringio'

module Paralyze
  class MultiProcessExampleGroupRunner
    DEFAULT_MAXIMUM_PROCESSES = 1
    attr_accessor :maximum_processes, :options

    def initialize(options, maximum_processes = DEFAULT_MAXIMUM_PROCESSES)
      parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
      parser.parse(options)
      self.options = parser.options
      self.maximum_processes = maximum_processes || DEFAULT_MAXIMUM_PROCESSES
    end
    
    def spec_file_paths
      options.files_to_load
    end
    
    def run
      options.run_examples
    end
  end
end
