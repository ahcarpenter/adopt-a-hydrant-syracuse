class Referee < ActiveRecord::Base
  attr_accessible :endpoint
  has_many :referrals
  
  def set_endpoint(value)
    referee = Referee.new
    referee.endpoint = value
    referee.save
    return referee
  end
end