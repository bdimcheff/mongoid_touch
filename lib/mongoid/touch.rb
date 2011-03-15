require 'active_support/concern'

module Mongoid::Touch
  extend ActiveSupport::Concern
  
  included do
    field :touched_at, :type => Time
  end
  
  module ClassMethods
    
  end
  
  def touch
    self.touched_at = Time.now.utc
    save
  end
end