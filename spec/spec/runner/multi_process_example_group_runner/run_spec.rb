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
    File.exists?(SpecHelper.sandbox_output_file) ? File.read(SpecHelper.sandbox_output_file) : "no file"
  end
  
  it "should should run directory" do
    new_runner_options(SpecHelper.fixtures_path,"-p", "**/*.rb", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner:6", "-f", "progress:#{SpecHelper.sandbox_output_file}").run_examples
    # output.should include("6 examples, 0 failures")
    output.should include("......")    
  end

  it "should run file" do
    new_runner_options(SpecHelper.fixtures_path,"-p", "string_spec.rb", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner:2", "-f", "progress:#{SpecHelper.sandbox_output_file}").run_examples
    # output.should include("2 examples, 0 failures")
    output.should include("..")    
  end
  
  it "should fork the specified number of times" do
    Process.stub!(:waitpid2).and_return([1337, mock("status", :exitstatus => 0)])
    Process.should_receive(:fork).exactly(4).times
    new_runner_options(SpecHelper.fixtures_path,"-p", "**/*.rb", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner:4", "-f", "progress:#{SpecHelper.sandbox_output_file}").run_examples
  end
  
  it "should raise when file does not exist" do
    lambda {    
      new_runner_options("/doesntexist'", "-U", "Paralyze::Runner::MultiProcessExampleGroupRunner", "-f", "progress:#{SpecHelper.sandbox_output_file}").run_examples
    }.should raise_error    
  end
end
