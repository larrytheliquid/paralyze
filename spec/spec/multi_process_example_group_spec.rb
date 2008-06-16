require File.dirname(__FILE__) + '/../spec_helper'

describe MultiProcessExampleGroupRunner, ".run" do
  it_should_behave_like "sandboxed rspec_options"
  attr_reader :options, :err, :out
  before do
    @err = options.error_stream
    @out = options.output_stream
  end
  
  it "should run directory" do
    file = File.dirname(__FILE__) + '/../fixtures'
    MultiProcessExampleGroupRunner.run(Spec::Runner::OptionParser.parse([file,"-p","**/*.rb"], @err, @out))
  
    @out.rewind
    @out.read.should =~ /\d+ examples, 0 failures/n
  end
  
  it "should run file" do
    file = File.dirname(__FILE__) + '/../fixtures/math_spec.rb'
    MultiProcessExampleGroupRunner.run(Spec::Runner::OptionParser.parse([file], @err, @out))
  
    @out.rewind
    @out.read.should =~ /2 examples, 0 failures/n
  end
  
  it "should raise when file does not exist" do
    file = File.dirname(__FILE__) + '/doesntexist'
  
    lambda {
      MultiProcessExampleGroupRunner.run(Spec::Runner::OptionParser.parse([file], @err, @out))
    }.should raise_error
  end
end