require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#load_files" do  
  before(:all) do
    @original_rspec_options = $rspec_options
  end
  
  before(:each) do
    options_parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
    options_parser.parse [SpecHelper.fixtures_path,"-p","**/*.rb", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner"]
    $rspec_options = @options = options_parser.options
    @multi_process_example_group_runner = @options.send(:custom_runner)
  end
  
  after(:each) do
    $rspec_options = @original_rspec_options    
  end
  
  it "should set partitioned_example_groups" do
    @multi_process_example_group_runner.load_files(@options.files_to_load)
    @multi_process_example_group_runner.partitioned_example_groups.should_not be_nil
  end
  
  it "should add subarrays to partitioned_example_groups" do
    @multi_process_example_group_runner.load_files(@options.files_to_load)
    @multi_process_example_group_runner.partitioned_example_groups.each{|group| group.should be_kind_of(Array) }
  end
  
  it "should use concurrent_processes based on the number of example groups" do
    @multi_process_example_group_runner.should_receive(:concurrent_processes).with(6).and_return(3)
    @multi_process_example_group_runner.load_files(@options.files_to_load)    
  end
end
