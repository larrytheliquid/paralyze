require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#child_output_path" do  
  before(:each) do
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
  end
  
  describe "without an output path" do
    it "should be 'PID.paralyze'" do
      @multi_process_example_group_runner.child_output_path(1337).should include("1337.paralyze")
    end
  end
  
  describe "with an output path" do
    it "should be the path specified with 'PID.paralyze' appended" do
      @multi_process_example_group_runner.child_output_path(1337, SpecHelper.sandbox_output_file).should include("#{SpecHelper.sandbox_output_file}.1337.paralyze")
    end
  end  
end
