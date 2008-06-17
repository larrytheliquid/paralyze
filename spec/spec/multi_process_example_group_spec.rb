require File.dirname(__FILE__) + '/../../lib/multi_process_example_group_runner.rb'
require 'stringio'

describe MultiProcessExampleGroupRunner, "when run after being specified as a custom runner in Options" do  
  before(:each) do
    @out = StringIO.new
    @err = StringIO.new
    @parser = Spec::Runner::OptionParser.new(@err, @out)
  end
  
  it "should be used" do
    @parser.parse(["--runner", "MultiProcessExampleGroupRunner"])
    options = @parser.options
    options.run_examples
  end
end

describe MultiProcessExampleGroupRunner, "#maximum_processes" do
  
  describe "for an instance passed nothing" do
    before(:each) do
      @multi_process_example_group_runner = MultiProcessExampleGroupRunner.new({})
    end
    
    it "should be 1" do
      @multi_process_example_group_runner.maximum_processes.should == 1
    end
  end
  
  describe "for an instance passed nil" do
    before(:each) do
      @multi_process_example_group_runner = MultiProcessExampleGroupRunner.new({}, nil)
    end
    
    it "should be 1" do
      @multi_process_example_group_runner.maximum_processes.should == 1
    end
  end
  
  describe "for an instance passed a number" do
    before(:each) do
      @multi_process_example_group_runner = MultiProcessExampleGroupRunner.new({}, 1337)
    end
    
    it "should be what was initialized" do
      @multi_process_example_group_runner.maximum_processes.should == 1337
    end

    it "should be what was set" do
      @multi_process_example_group_runner.maximum_processes = 7331
      @multi_process_example_group_runner.maximum_processes.should == 7331
    end
  end
  
end

# describe MultiProcessExampleGroupRunner, ".new" do
#   # it_should_behave_like "sandboxed rspec_options"
#   # attr_reader :options, :err, :out
#   # before do
#   #   @err = options.error_stream
#   #   @out = options.output_stream
#   # end
#   
#   before(:each) do
#     @out = StringIO.new
#     @err = StringIO.new
#     @parser = Spec::Runner::OptionParser.new(@err, @out)
#   end
#   
#   it "should be used when specified as a custom Runner" do
#     runner = Custom::ExampleGroupRunner.new(@parser.options, nil)
#     @parser.parse(["--runner", "MultiProcessExampleGroupRunner"])
#     options = @parser.options
#     options.run_examples
#   end
#   
#   # it "should run directory" do
#   #   file = File.dirname(__FILE__) + '/../fixtures'
#   #   MultiProcessExampleGroupRunner.new( Spec::Runner::OptionParser.parse([file,"-p","**/*.rb"], @err, @out) ).run
#   # 
#   #   @out.rewind
#   #   @out.read.should =~ /\d+ examples, 0 failures/n
#   # end
#   
#   # it "should run file" do
#   #   file = File.dirname(__FILE__) + '/../fixtures/math_spec.rb'
#   #   @parser.parse([file, "--runner", "MultiProcessExampleGroupRunner"])    
#   #   # parser.parse([file, "--format", "html"])    
#   #   # parser.parse([file])    
#   #   # puts parser.options.inspect
#   #   # puts MultiProcessExampleGroupRunner.new( Spec::Runner::OptionParser.parse([file], @err, @out) ).send(:number_of_examples)
#   #   
#   #   # puts @parser.options.send(:custom_runner).inspect
#   #   
#   #   @parser.options.run_examples
#   # 
#   #   # @out.rewind
#   #   # @out.read.should =~ /2 examples, 0 failures/n
#   # end
#   
#   # it "should raise when file does not exist" do
#   #   file = File.dirname(__FILE__) + '/doesntexist'
#   # 
#   #   lambda {
#   #     MultiProcessExampleGroupRunner.new( Spec::Runner::OptionParser.parse([file], @err, @out) ).run
#   #   }.should raise_error
#   # end
# end

# it "should be used" do
#   runner = Custom::ExampleGroupRunner.new(@parser.options, nil)
#   @parser.parse(["--runner", "MultiProcessExampleGroupRunner"])
#   options = @parser.options
#   options.run_examples
# end