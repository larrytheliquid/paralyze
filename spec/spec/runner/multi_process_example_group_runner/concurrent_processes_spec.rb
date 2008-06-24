require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#concurrent_processes" do  
  describe "with an integer maximum processes" do
    describe "when the maximum processes is equal to the number of spec files" do
      before(:each) do
        @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], 3)
      end

      it "should be the number of spec files" do
        @multi_process_example_group_runner.concurrent_processes(3).should == 3
      end
    end

    describe "when maximum processes is less than the number of spec files" do
      before(:each) do
        @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], 3)
      end

      it "should be the maximum processes" do
        @multi_process_example_group_runner.concurrent_processes(4).should == 3
      end
    end

    describe "when number of spec files is less than the maximum processes" do
      before(:each) do
        @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], 4)
      end

      it "should be the number of spec files" do
        @multi_process_example_group_runner.concurrent_processes(3).should == 3
      end
    end
  end
  
  describe "with a string maximum processes" do
    describe "when the maximum processes is equal to the number of spec files" do
      before(:each) do
        @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], "3")
      end

      it "should be the number of spec files" do
        @multi_process_example_group_runner.concurrent_processes(3).should == 3
      end
    end

    describe "when maximum processes is less than the number of spec files" do
      before(:each) do
        @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], "3")
      end

      it "should be the maximum processes" do
        @multi_process_example_group_runner.concurrent_processes(4).should == 3
      end
    end

    describe "when number of spec files is less than the maximum processes" do
      before(:each) do
        @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb"], "4")
      end

      it "should be the number of spec files" do
        @multi_process_example_group_runner.concurrent_processes(3).should == 3
      end
    end
  end
end