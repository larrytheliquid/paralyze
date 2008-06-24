require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#run" do  
  before(:all) do
    @original_rspec_options = $rspec_options
  end
  
  after(:each) do
    FileUtils.rm SpecHelper.sandbox_output_file if File.exists?(SpecHelper.sandbox_output_file)
    $rspec_options = @original_rspec_options    
  end
  
  def new_runner_options(*opts)
    @out = StringIO.new
    options_parser = Spec::Runner::OptionParser.new(StringIO.new, @out)
    options_parser.parse opts
    $rspec_options = @options = options_parser.options
  end
  
  def output
    @out.rewind
    @out.read
  end
  
  it "should should run directory" do
    new_runner_options(SpecHelper.fixtures_path,"-p", "**/*.rb", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner").run_examples
    output.should include("6 examples, 0 failures")
  end

  it "should run file" do
    new_runner_options(SpecHelper.fixtures_path,"-p", "string_spec.rb", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner").run_examples
    output.should include("2 examples, 0 failures")
  end
  
  it "should raise when file does not exist" do
    lambda {    
      new_runner_options("/doesntexist'", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner").run_examples
    }.should raise_error    
  end
end
