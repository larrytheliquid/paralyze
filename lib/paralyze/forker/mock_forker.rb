module Paralyze
  module Forker
    class MockForker
      def self.fork
        yield
      end
    end
  end
end