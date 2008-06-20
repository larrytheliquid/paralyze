require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#fork" do  
  before(:each) do
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
  end
      
  describe "by default" do
    it "should delegate to Paralyze::Forker::ProcessForker.fork" do
      Paralyze::Forker::ProcessForker.should_receive(:fork)
      @multi_process_example_group_runner.fork { "hardcore forking action" }
    end
  end
  
  describe "when set" do
    it "should delegate to the set Forker class' 'fork' class method" do
      @multi_process_example_group_runner.forker = Paralyze::Forker::MockForker
      Paralyze::Forker::MockForker.should_receive(:fork)
      @multi_process_example_group_runner.fork { "hardcore forking action" }
    end
  end  
end