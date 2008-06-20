require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#load_files" do  
  before(:each) do
    options_parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
    options_parser.parse [SpecHelper.fixtures_path,"-p","**/*.rb"]
    @options = options_parser.options
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
  end
  
  it "should set @example_group_runners" do
    @multi_process_example_group_runner.load_files(@options.files_to_load)
    @multi_process_example_group_runner.should be_instance_variable_defined(:@example_group_runners)
  end
  
  it "should add Spec::Runner::ExampleGroupRunner instances to example_group_runners" do
    @multi_process_example_group_runner.load_files(@options.files_to_load)
    @multi_process_example_group_runner.example_group_runners.each{|runner| runner.should be_kind_of(Spec::Runner::ExampleGroupRunner) }
  end
end
