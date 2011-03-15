require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class TsaAgent
  include Mongoid::Document
  include Mongoid::Touch
  
  field :name
end

Fabricator(:tsa_agent) do
  name "Joe"
end

describe Mongoid::Touch do
  let(:base_time) { Time.utc(2011, 1, 1) }
  
  context "a single instance" do
    let(:agent) { Fabricate :tsa_agent }

    it "provides a .touch method" do
      agent.should respond_to(:touch)
    end

    it "records when it is touched" do
      Timecop.freeze(base_time) do
        agent.touch
      end
      
      agent.touched_at.should == base_time
    end
    
    it "persists across reloads" do
      Timecop.freeze(base_time) do
        agent.touch
      end
      
      agent.reload.touched_at.should == base_time
    end
    
    it "doesn't save other dirty attributes" do
      pending "Would this be helpful to anyone?"
      
      # Should save not be called at all?  Instead update attribute directly?
      
      agent.name = "Sam"
      
      Timecop.freeze(base_time) do
        agent.touch
      end
      
      agent.reload.name.should == "Joe"
    end
  end
end
