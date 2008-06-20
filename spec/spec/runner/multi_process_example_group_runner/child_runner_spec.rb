require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#child_runner" do  
  before(:each) do
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb", "-f", "progress:#{SpecHelper.sandbox_output_file}"])
  end
  
  it "should be a runner with the spec files specified" do
    pending
  end
end
