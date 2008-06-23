require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#run" do  
  before(:all) do
    @original_rspec_options = $rspec_options
  end
  
  after(:each) do
    FileUtils.rm SpecHelper.sandbox_output_file if File.exists?(SpecHelper.sandbox_output_file)
    $rspec_options = @original_rspec_options    
  end
  
  def new_runner(*opts)
    new_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new(opts)    
    $rspec_options = new_runner.options
    new_runner
  end
  
  def output
    File.read SpecHelper.sandbox_output_file
  end
  
  it "should should run directory" do
    pending
    new_runner(SpecHelper.fixtures_path,"-p", "**/*.rb", "-f", "progress:#{SpecHelper.sandbox_output_file}").run
    output.should include("6 examples, 0 failures")
  end

  it "should run file" do
    pending
    new_runner(SpecHelper.fixtures_path,"-p", "string_spec.rb", "-f", "progress:#{SpecHelper.sandbox_output_file}").run
    output.should include("2 examples, 0 failures")
  end
  
  it "should raise when file does not exist" do
    pending
    lambda {    
      new_runner("/doesntexist'", "-f", "progress:#{SpecHelper.sandbox_output_file}").run
    }.should raise_error    
  end  
  
  it "should return true when in --generate-options mode" do        
    pending
    new_runner('--generate-options', '/tmp/foo').run.should be_true
  end

  it "should dump even if Interrupt exception is occurred" do
    pending
    example_group = Class.new(::Spec::Example::ExampleGroup) do
      describe("example_group")
      it "no error" do
      end

      it "should interrupt" do
        raise Interrupt, "I'm interrupting"
      end
    end

    options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    ::Spec::Runner::Options.should_receive(:new).and_return(options)
    options.reporter.should_receive(:dump)
    options.add_example_group(example_group)

    new_runner.run
  end
  
  it "should heckle when options have heckle_runner" do
    pending
    example_group = Class.new(::Spec::Example::ExampleGroup).describe("example_group") do
      it "no error" do
      end
    end
    options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    ::Spec::Runner::Options.should_receive(:new).and_return(options)
    options.add_example_group example_group
  
    heckle_runner = mock("heckle_runner")
    heckle_runner.should_receive(:heckle_with)
    $rspec_mocks.__send__(:mocks).delete(heckle_runner)
  
    options.heckle_runner = heckle_runner
    options.add_example_group(example_group)
  
    new_runner.run
    heckle_runner.rspec_verify
  end
  
  it "should run examples backwards if options.reverse is true" do
    pending
    options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    ::Spec::Runner::Options.should_receive(:new).and_return(options)
    options.reverse = true
  
    b1 = Class.new(Spec::Example::ExampleGroup)
    b2 = Class.new(Spec::Example::ExampleGroup)
  
    b2.should_receive(:run).ordered
    b1.should_receive(:run).ordered
  
    options.add_example_group(b1)
    options.add_example_group(b2)
  
    new_runner.run
  end
  
  it "should pass its ExampleGroup to the reporter" do
    pending
    example_group = Class.new(::Spec::Example::ExampleGroup).describe("example_group") do
      it "should" do
      end
    end
    options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    options.add_example_group(example_group)
  
    ::Spec::Runner::Options.should_receive(:new).and_return(options)
    options.reporter.should_receive(:add_example_group).with(example_group)
    
    new_runner.run
  end
  
  it "runs only selected Examples when options.examples is set" do
    pending
    options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    ::Spec::Runner::Options.should_receive(:new).and_return(options)
  
    options.examples << "example_group should"
    should_has_run = false
    should_not_has_run = false
    example_group = Class.new(::Spec::Example::ExampleGroup).describe("example_group") do
      it "should" do
        should_has_run = true
      end
      it "should not" do
        should_not_has_run = true
      end
    end
  
    options.reporter.should_receive(:add_example_group).with(example_group)
  
    options.add_example_group example_group
    new_runner.run
  
    should_has_run.should be_true
    should_not_has_run.should be_false
  end
  
  it "sets Spec.run to true" do
    pending
    ::Spec.run = false
    ::Spec.should_not be_run
    new_runner.run
    ::Spec.should be_run
  end
end
