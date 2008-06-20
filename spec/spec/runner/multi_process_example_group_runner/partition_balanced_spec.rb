require File.dirname(__FILE__) + '/../../spec_helper'

describe Paralyze::Runner::MultiProcessExampleGroupRunner, "#partition_balanced" do
  before(:each) do
    @multi_process_example_group_runner = Paralyze::Runner::MultiProcessExampleGroupRunner.new([])
  end
  
  it "should not be destructive" do
    array = [1, 2, 3, 4, 5, 6, 7, 8]
    @multi_process_example_group_runner.partition_balanced(4, array)
    array.should == [1, 2, 3, 4, 5, 6, 7, 8]
  end
  
  describe "when the number of partitions is 1" do
    it "should be one partition" do
      @multi_process_example_group_runner.partition_balanced(1, [1, 2, 3, 4, 5, 6, 7, 8]).should == [[1, 2, 3, 4, 5, 6, 7, 8]]
    end
  end
  
  describe "when the number of partitions is greater than 1" do
    describe "and the resulting array is even" do
      it "should be equal partitions for small numbers of partitions" do
        @multi_process_example_group_runner.partition_balanced(2, [1, 2, 3, 4, 5, 6]).should == [[1, 2, 3], [4, 5, 6]]        
      end
      
      it "should be equal partitions for medium numbers of partitions" do
        @multi_process_example_group_runner.partition_balanced(2, [1, 2, 3, 4, 5, 6, 7, 8]).should == [[1, 2, 3, 4], [5, 6, 7, 8]]        
      end
      
      it "should be equal partitions for large numbers of partitions" do
        @multi_process_example_group_runner.partition_balanced(4, [1, 2, 3, 4, 5, 6, 7, 8]).should == [[1, 2], [3, 4], [5, 6], [7, 8]]
      end
    end
    
    describe "and the resulting array is odd" do
      it "should be balanced partitions for small numbers of partitions" do
        @multi_process_example_group_runner.partition_balanced(2, [1, 2, 3, 4, 5, 6, 7]).should == [[1, 2, 3, 4], [5, 6, 7]]          
      end
      
      it "should be balanced partitions for medium numbers of partitions" do     
        @multi_process_example_group_runner.partition_balanced(3, [1, 2, 3, 4, 5, 6, 7]).should == [[1, 2, 3], [4, 5], [6, 7]]        
      end
      
      it "should be balanced partitions for large numbers of partitions" do     
        @multi_process_example_group_runner.partition_balanced(3, [1, 2, 3, 4, 5, 6, 7, 8]).should == [[1, 2, 3], [4, 5, 6], [7, 8]]        
      end
    end    
  end
end