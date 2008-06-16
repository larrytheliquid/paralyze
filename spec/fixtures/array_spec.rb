describe "[1, 2] + [3]" do
  it "should be [1, 2, 3]" do
    ([1, 2] + [3]).should == [1, 2, 3]
  end
end

describe "[1, 2] - [2]" do
  it "should be [1]" do
    ([1, 2] - [2]).should == [1]
  end
end
