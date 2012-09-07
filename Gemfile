# http://about.travis-ci.org/docs/user/languages/ruby/
source 'https://rubygems.org'

gem 'rails'
gem 'arel'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'http_accept_language'
gem 'pg'
gem 'rails_admin'
gem 'validates_formatting_of'
gem 'immigrant'
gem 'libxml-ruby'
gem 'referthis'
gem 'koala'

platforms :ruby_18 do
  gem 'fastercsv'
end

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
  gem 'font-awesome-sass-rails', '2.0.0.0'
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