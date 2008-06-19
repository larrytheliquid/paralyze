require File.dirname(__FILE__) + '/../spec_helper'

describe Paralyze::MultiProcessExampleGroupRunner, "#concurrent_processes" do  
  describe "when the maximum processes is equal to the number of spec files" do
    before(:each) do
      @multi_process_example_group_runner = Paralyze::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], 3)
      @multi_process_example_group_runner.stub!(:spec_file_paths).and_return(["a.txt", "b.txt", "c.txt"])
    end
    
    it "should be the number of spec files" do
      @multi_process_example_group_runner.should_receive(:spec_file_paths).and_return(["a.txt", "b.txt", "c.txt"])      
      @multi_process_example_group_runner.concurrent_processes.should == 3
    end
  end
  
  describe "when maximum processes is less than the number of spec files" do
    before(:each) do
      @multi_process_example_group_runner = Paralyze::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], 3)
      @multi_process_example_group_runner.stub!(:spec_file_paths).and_return(["a.txt", "b.txt", "c.txt", "d.txt"])      
    end
    
    it "should be the maximum processes" do
      @multi_process_example_group_runner.should_receive(:spec_file_paths).and_return(["a.txt", "b.txt", "c.txt", "d.txt"])
      @multi_process_example_group_runner.concurrent_processes.should == 3
    end
  end
  
  describe "when number of spec files is less than the maximum processes" do
    before(:each) do
      @multi_process_example_group_runner = Paralyze::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], 4)
      @multi_process_example_group_runner.stub!(:spec_file_paths).and_return(["a.txt", "b.txt", "c.txt"])
    end
    
    it "should be the number of spec files" do
      @multi_process_example_group_runner.should_receive(:spec_file_paths).and_return(["a.txt", "b.txt", "c.txt"])      
      @multi_process_example_group_runner.concurrent_processes.should == 3
    end
  end
end