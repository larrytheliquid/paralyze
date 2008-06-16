require 'spec'
require 'stringio'
require File.dirname(__FILE__) + '/../lib/multi_process_example_group_runner.rb'

describe "sandboxed rspec_options", :shared => true do
  attr_reader :options

  before(:all) do
    @original_rspec_options = $rspec_options
  end

  before(:each) do
    @options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new)
    $rspec_options = options
  end

  after do
    $rspec_options = @original_rspec_options
  end
end
