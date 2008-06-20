require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#child_runner" do  
  before(:each) do
    # TODO: Use an actual CommandLine runner here that uses the custom runner
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([SpecHelper.fixtures_path,"-p","**/*.rb", "-f", "progress:#{SpecHelper.sandbox_output_file}"])
  end
  
  it "should be a Spec::Runner::ExampleGroupRunner" do
    @multi_process_example_group_runner.child_runner(1337, ["abc.txt"]).should be_kind_of(Spec::Runner::ExampleGroupRunner)
  end
  
  it "should not have a custom runner as one of its options" do
    pending "using the custom runner via CommandLine"
    @multi_process_example_group_runner.child_runner(1337, ["abc.txt"]).options.should_not be_custom_runner
  end
  
  # correct file path name based on pid
  
  # using correct files
end
