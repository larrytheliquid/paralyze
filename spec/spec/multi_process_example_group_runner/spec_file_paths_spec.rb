require File.dirname(__FILE__) + '/../spec_helper'
require 'stringio'

describe Paralyze::MultiProcessExampleGroupRunner, "#spec_file_paths" do
  before(:each) do
    @out = StringIO.new
    @err = StringIO.new
    options = [SpecHelper.fixtures_path,"-p","**/*.rb"]
    
    @multi_process_example_group_runner = Paralyze::MultiProcessExampleGroupRunner.new(options)    
  end
  
  it "should be an Array" do
    @multi_process_example_group_runner.spec_file_paths.should be_kind_of(Array)
  end
  
  it "should have a size equal to the total number of spec files" do
    @multi_process_example_group_runner.spec_file_paths.size.should == 3    
  end
  
  it "should include the paths of all the files" do
    @multi_process_example_group_runner.spec_file_paths.each {|path| File.exists?(path).should be_true }
  end
end