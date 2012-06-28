class Referral < ActiveRecord::Base
  attr_accessible :clicked_through, :referee_id, :user_id

  def construct(referee_id)
    referral = Referral.new
    referral.referee_id = referee_id
    referral.user_id = User.current.id
    referral.save
    return referral
  end
  
  def self.generate_referral(attributes)
      if attributes[:phone_number] != ''
        if Referee.exists?(:endpoint => SMS.sieve(attributes[:phone_number]))
          referee = Referee.find_by_endpoint(SMS.sieve(attributes[:phone_number]).to_s)
        else
          referee = Referee.new.set_endpoint(SMS.sieve(attributes[:phone_number]).to_s)
        end
        referral = Referral.new.construct(referee.id)
        SMS.send_referral(referral)
      end
      
      if attributes[:email_address] != ''
        if Referee.exists?(:endpoint => attributes[:email_address])
          referee = Referee.find_by_endpoint(attributes[:email_address])
        else
          referee = Referee.new.set_endpoint(attributes[:email_address])
        end
        referral = Referral.new.construct(referee.id)
        ThingMailer.send_referral(referral).deliver
      end
  end
  
  def self.percent_clicked_through
    return ((Referral.where('visits > 0').count.to_f / Referral.count.to_f) * 100).to_s + '%'
  end
  
  def self.percent_email_clicked_through
    referrals = Referral.all
    if referrals.any?
      count = 0
      clicked_through = 0
      for referral in referrals
        if Referee.find(referral.referee_id).endpoint.include? '@'
          # puts Referee.find(referral.referee_id).endpoint
          count += 1 
          clicked_through += 1 if referral.visits > 0
        end
      end
      return ((clicked_through.to_f / count.to_f) * 100).to_s + '%'
    else
      return '0%'
    end
  end
  
  def self.percent_sms_clicked_through
    referrals = Referral.all
    if referrals.any?
      count = 0
      clicked_through = 0
      for referral in referrals
        if !Referee.find(referral.referee_id).endpoint.include? '@'
          # puts Referee.find(referral.referee_id).endpoint
          count += 1 
          clicked_through += 1 if referral.visits > 0
        end
      end
      return ((clicked_through.to_f / count.to_f) * 100).to_s + '%'
    else
      return '0%'
    end
  end
  
  def self.test
    referrals = Referral.select('user_id').uniq
    greatest_clickthrough_rate = 0.0
    user_with_greatest_clickthrough_rate = ''
    for referral in referrals
      referral_user_id = referral.user_id
      total_referrals_clicked_through =  Referral.where('user_id = ' + referral.user_id.to_s).where('visits > 0').count
      total_referrals = Referral.where('user_id = ' + referral.user_id.to_s).count
      clickthrough_rate = (total_referrals_clicked_through.to_f / total_referrals.to_f * 100)
      if clickthrough_rate > greatest_clickthrough_rate
        greatest_clickthrough_rate = clickthrough_rate
        user_with_greatest_clickthrough_rate = referral.user_id
      end
      puts '| Overall clickthrough rate | ' + (total_referrals_clicked_through.to_f / total_referrals.to_f * 100).to_s + '%   |'
      puts '---------------------------------------------------'
    end
    puts User.find(user_with_greatest_clickthrough_rate).name + ' exhibits the greatest clickthrough rate of any user at ' + greatest_clickthrough_rate.to_s + '%'
  end
  
  def self.test1
    if self.percent_sms_clicked_through.to_f > self.percent_email_clicked_through.to_f
      puts 'SMS exhibits the greatest clickthrough rate of any medium at ' + self.percent_sms_clicked_through
    else
      puts 'Email exhibits the greatest clickthrough rate of any medium at ' + self.percent_email_clicked_through
    end
  end
  
  def stats
    puts '------------------------------------------------'
    puts 'Email clickthrough rate   | ' + self.percent_email_clicked_through + ' |'
    puts '------------------------------------------------'
    puts 'SMS clickthrough rate    | ' + self.percent_sms_clicked_through + ' |'
    puts '------------------------------------------------'
    self.test
    self.test1
  end
    
  def self.resolve_token(token)
    referral_id = Base64::decode64(token)
    if self.exists?(:id => referral_id)
      referral = self.find(referral_id) 
      referral.visits = referral.visits + 1
      referral.save
    end
    # puts self.percent_clicked_through
    # puts '---------------------------------------------------'
    # puts '| Email clickthrough rate   | ' + self.percent_email_clicked_through + '  |'
    # puts '---------------------------------------------------'
    # puts '| SMS clickthrough rate     | ' + self.percent_sms_clicked_through + ' |'
    # puts '---------------------------------------------------'
    # self.test
    # self.test1
  end
end