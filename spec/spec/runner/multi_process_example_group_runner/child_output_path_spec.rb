require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#child_output_path" do  
  before(:each) do
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb", "-f", "progress:#{SpecHelper.sandbox_output_file}"])
  end
  
  describe "without an output file specified in the spec options" do
    it "should be the default path with 'PID.paralyze' appended" do
      @multi_process_example_group_runner.child_output_path(1337).should include("default.1337.paralyze")
    end
  end
  
  describe "with an output file specified in the spec options" do
    it "should be the path specified with 'PID.paralyze' appended" do
      pending
      @multi_process_example_group_runner.child_output_path(1337).should include("#{SpecHelper.sandbox_output_file}.1337.paralyze")
    end
  end  
end
