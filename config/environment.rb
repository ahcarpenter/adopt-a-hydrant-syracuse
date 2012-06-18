# http://www.rubyinside.com/how-to-use-gmails-smtp-server-with-rails-394.html
# http://www.whatcodecraves.com/articles/2010/01/11/ruby_rails_gmail_smtp/
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AdoptAThing::Application.initialize!
# Don't care if the mailer can't send
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_url_options = {:host => 'localhost:3000'}
# set delivery method to :smtp, :sendmail or :test
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
# these options are only needed if you choose smtp delivery
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :authentication => :plain,
  :domain         => 'mail.google.com',
  :user_name      => 'adoptahydrantsyracuse@gmail.com',
  :password       => 'Drewby!23'
}