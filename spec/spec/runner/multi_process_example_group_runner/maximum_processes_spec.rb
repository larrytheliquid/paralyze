require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#maximum_processes" do
  
  describe "for an instance passed nothing" do
    before(:each) do
      @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
    end
    
    it "should be Paralyze::Runner::MultiProcessExampleGroupRunner::DEFAULT_MAXIMUM_PROCESSES" do
      @multi_process_example_group_runner.maximum_processes.should == Paralyze::Runner::MultiProcessExampleGroupRunner::DEFAULT_MAXIMUM_PROCESSES
    end
  end
  
  describe "for an instance passed nil" do
    before(:each) do
      @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([], nil)
    end
    
    it "should be Paralyze::Runner::MultiProcessExampleGroupRunner::DEFAULT_MAXIMUM_PROCESSES" do
      @multi_process_example_group_runner.maximum_processes.should == Paralyze::Runner::MultiProcessExampleGroupRunner::DEFAULT_MAXIMUM_PROCESSES
    end
  end
  
  describe "for an instance passed a number" do
    before(:each) do
      @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([], 1337)
    end
    
    it "should be what was initialized" do
      @multi_process_example_group_runner.maximum_processes.should == 1337
    end

    it "should be what was set" do
      @multi_process_example_group_runner.maximum_processes = 7331
      @multi_process_example_group_runner.maximum_processes.should == 7331
    end
  end
  
end