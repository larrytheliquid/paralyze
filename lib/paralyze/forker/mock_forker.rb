module Paralyze
  module Forker
    class MockForker < MotherForker
      @@pid_count = 0
      
      def self.fork
        yield
        @@pid_count += 1
      end
    end
  end
end