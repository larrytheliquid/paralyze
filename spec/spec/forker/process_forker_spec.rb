require File.dirname(__FILE__) + '/../spec_helper'

describe Paralyze::Forker::ProcessForker, ".fork" do
  before(:each) do
    @process_fork = Paralyze::Forker::ProcessForker
  end
  
  describe "for a cleanly running process" do
    before(:each) do
      @fork_me = mock("fork me", :call_me => "hardcore forking action")
    end
    
    it "should evaluate the block in a separate process" do
      @fork_me.should_not_receive(:call_me)
      @process_fork.fork { @fork_me.call_me }
    end
    
    it "should return the PID of the block forked" do
      pid = @process_fork.fork { @fork_me.call_me }
      Process.waitpid2(pid).first.should == pid
    end

    it "should exit the fork'd process with an existstatus of 0 (successful)" do
      pid = @process_fork.fork { @fork_me.call_me }
      Process.waitpid2(pid).last.exitstatus.should be_zero
    end
  end
  
  describe "for a process raising an Exception" do
    before(:each) do
      @fork_me = mock("fork me")
      @fork_me.stub!(:call_me).and_raise(Exception)
    end
    
    it "should evaluate the block in a separate process" do
      @fork_me.should_not_receive(:call_me)
      @process_fork.fork { @fork_me.call_me }
    end
    
    it "should return the PID of the block forked" do
      pid = @process_fork.fork { @fork_me.call_me }
      Process.waitpid2(pid).first.should == pid
    end

    it "should exit the fork'd process with an existstatus of 0 (successful)" do
      pid = @process_fork.fork { @fork_me.call_me }
      Process.waitpid2(pid).last.exitstatus.should be_zero
    end
  end
end