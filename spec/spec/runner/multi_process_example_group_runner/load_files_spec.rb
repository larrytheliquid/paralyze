require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#load_files" do  
  before(:each) do
    options_parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
    options_parser.parse [SpecHelper.fixtures_path,"-p","**/*.rb"]
    @options = options_parser.options
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
  end
  
  it "should set @example_group_runner_file_path_partitions" do
    @multi_process_example_group_runner.load_files(@options.files_to_load)
    @multi_process_example_group_runner.should be_instance_variable_defined(:@example_group_runner_file_path_partitions)
  end
  
  it "should add subarrays to example_group_runner_file_path_partitions" do
    @multi_process_example_group_runner.load_files(@options.files_to_load)
    @multi_process_example_group_runner.example_group_runner_file_path_partitions.each{|runner| runner.should be_kind_of(Array) }
  end
  
  it "should use concurrent_processes" do
    @multi_process_example_group_runner.should_receive(:concurrent_processes).and_return(3)
    @multi_process_example_group_runner.load_files(@options.files_to_load)    
  end
end
