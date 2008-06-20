require File.dirname(__FILE__) + '/../spec_helper'

describe Paralyze::Forker::ProcessForker, ".fork" do
  before(:each) do
    @process_fork = Paralyze::Forker::ProcessForker
  end
  
  describe "for a cleanly running process" do
    it "should return the PID of the block forked" do
      pid = @process_fork.fork { "hardcore forking action" }
      Process.waitpid2(pid).first.should == pid
    end

    it "should exit the fork'd process with an existstatus of 0 (successful)" do
      pid = @process_fork.fork { "hardcore forking action" }
      Process.waitpid2(pid).last.exitstatus.should be_zero
    end
  end
  
  describe "for a process raising an Exception" do
    it "should return the PID of the block forked" do
      pid = @process_fork.fork { raise Exception }
      Process.waitpid2(pid).first.should == pid
    end

    it "should exit the fork'd process with an existstatus of 0 (successful)" do
      pid = @process_fork.fork { raise Exception }
      Process.waitpid2(pid).last.exitstatus.should be_zero
    end
  end
end