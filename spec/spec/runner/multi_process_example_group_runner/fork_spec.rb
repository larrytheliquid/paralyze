require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#fork" do  
  before(:each) do
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
  end
  
  it "should return the PID of the block forked" do
    pending "figure out how to test this without actually duplicating the tests being run in a separate process =)"
    pid = @multi_process_example_group_runner.fork { "hardcore forking action" }
    Process.waitpid2(pid).first.should == pid
  end  
end