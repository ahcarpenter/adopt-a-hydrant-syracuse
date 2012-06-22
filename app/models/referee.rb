class Referee < ActiveRecord::Base
  attr_accessible :endpoint
  has_many :referrals
  
  # def self.endpoint(value)
  #   self.endpoint = value
  #   self.save
  #   return self
  # end
end
