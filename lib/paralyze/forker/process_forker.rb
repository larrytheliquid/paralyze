module Paralyze
  module Forker
    class ProcessForker
      def self.fork
        Process.fork { begin yield ensure Process.exit!(0) end }
      end
    end
  end
end