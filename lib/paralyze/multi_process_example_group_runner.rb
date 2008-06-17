module Paralyze
  class MultiProcessExampleGroupRunner < Spec::Runner::ExampleGroupRunner
    DEFAULT_MAXIMUM_PROCESSES = 1
    attr_accessor :maximum_processes

    def initialize(options, maximum_processes = DEFAULT_MAXIMUM_PROCESSES)
      super(options)
      self.maximum_processes = maximum_processes || DEFAULT_MAXIMUM_PROCESSES
    end
  end
end
