require File.dirname(__FILE__) + '/../spec_helper'

describe Paralyze::Forker::MockForker, ".fork" do
  before(:each) do
    @mock_fork = Paralyze::Forker::MockForker
  end
  
  it "should immediately evaluate" do
    @mock_fork.fork { "hardcore forking action" }.should == "hardcore forking action"
  end
end