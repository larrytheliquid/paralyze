require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#child_runner" do  
  before(:all) do
    @original_rspec_options = $rspec_options
  end
  
  before(:each) do
    options_parser = Spec::Runner::OptionParser.new(StringIO.new, StringIO.new)
    options_parser.parse [SpecHelper.fixtures_path,"-p","**/*.rb", "-f", "progress:#{SpecHelper.sandbox_output_file}", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner"]
    options = options_parser.options
    @multi_process_example_group_runner = options.send(:custom_runner)
    $rspec_options = @multi_process_example_group_runner.options
  end
  
  after(:each) do
    $rspec_options = @original_rspec_options    
  end
  
  it "should be a Spec::Runner::ExampleGroupRunner" do
    @multi_process_example_group_runner.child_runner(1337, [File.join(SpecHelper.fixtures_path, "string_spec.rb")]).should be_kind_of(Spec::Runner::ExampleGroupRunner)
  end
  
  it "should not have a custom runner as one of its @options" do
    @multi_process_example_group_runner.child_runner(1337, [File.join(SpecHelper.fixtures_path, "string_spec.rb")]).instance_variable_get(:@options).should_not be_custom_runner
  end
  
  it "should have the correct file output path based on its PID" do
    pending
    # puts @multi_process_example_group_runner.child_runner(1337, [File.join(SpecHelper.fixtures_path, "string_spec.rb")]).instance_variable_get(:@format_options).inspect
    puts @multi_process_example_group_runner.child_runner(1337, [File.join(SpecHelper.fixtures_path, "string_spec.rb")]).instance_variable_get(:@options).output_stream.inspect    
  end
  
  it "should load the files passed to it" do
    @multi_process_example_group_runner.child_runner(1337, [File.join(SpecHelper.fixtures_path, "string_spec.rb")]).send(:example_groups).size.should == 2    
  end
end
