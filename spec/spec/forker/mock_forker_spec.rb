require File.dirname(__FILE__) + '/../spec_helper'

describe Paralyze::Forker::MockForker, ".fork" do
  before(:each) do
    @mock_fork = Paralyze::Forker::MockForker
    @fork_me = mock("fork me", :call_me => "hardcore forking action")
  end
  
  it "should evaluate the block in the same process" do
    @fork_me.should_receive(:call_me).and_return("hardcore forking action")
    @mock_fork.fork { @fork_me.call_me }
  end
  
  it "should return a mock PID Integer" do
    @mock_fork.fork { @fork_me.call_me }.should be_kind_of(Integer)
  end
  
  it "should be unique" do
    old_pid = @mock_fork.fork { "hardcore forking action" }
    @mock_fork.fork { @fork_me.call_me }.should_not == old_pid
  end
end