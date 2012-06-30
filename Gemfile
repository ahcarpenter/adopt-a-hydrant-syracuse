# http://about.travis-ci.org/docs/user/languages/ruby/
source 'https://rubygems.org'

gem 'rails', '~> 3.2'

gem 'arel'
gem 'devise'
gem 'geokit'
gem 'haml', '~> 3.2.0.alpha'
gem 'http_accept_language'
gem 'pg'
gem 'rails_admin'
gem 'validates_formatting_of'
gem 'immigrant'
gem 'twilio-ruby'
gem 'libxml-ruby'
gem 'referthis', '0.3.1'

platforms :ruby_18 do
  gem 'fastercsv'
end

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
  gem 'font-awesome-sass-rails'
end

group :production do
  gem 'puma'
end

group :test do
  gem 'simplecov'
  gem 'sqlite3'
  gem 'webmock'
  gem 'rake'
end