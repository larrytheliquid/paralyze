require File.dirname(__FILE__) + '/../../lib/paralyze'

class SpecHelper
  def self.fixtures_path
    File.dirname(__FILE__) + '/../fixtures'
  end
  
  def self.sandbox_path
    File.dirname(__FILE__) + '/../sandbox'    
  end
  
  def self.sandbox_output_file
    File.join(self.sandbox_path, "output.txt")
  end
end
