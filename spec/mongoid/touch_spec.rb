require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class TsaAgent
  include Mongoid::Document
  include Mongoid::Touch
end

describe Mongoid::Touch do
  it "provides a .touch method" do
    TsaAgent.new.should respond_to(:touch)
  end
end
