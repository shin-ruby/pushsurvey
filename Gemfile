source 'http://rubygems.org'
#  source 'http://ruby.taobao.org'




gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development,:test do
  gem 'sqlite3'
end

gem "meta_search",    '>= 1.1.0.pre'
gem "rails-i18n"
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'sass-rails',   '~> 3.2.3'



gem 'json'
gem 'roo'
gem 'zip'
gem 'nokogiri'
gem 'pony'


gem 'devise'
gem 'jquery-rails'
gem 'activeadmin'
gem "bourbon", "1.4.0"
gem "cancan"

#gem "paperclip"
#gem 'carrierwave'
gem 'carrierwave_direct'
gem "fog"


#gem 'validation_group', :git=>'git://github.com/akira/validationgroup.git'
#gem 'grouped_validations'
gem 'delayed_job'
gem 'delayed_job_active_record'

gem "airbrake"

#gem 'hoe', '~> 1.5.1' # Heroku's rubygems is too old for hoe 2.9.1 as of 28 Mar 201
if File.exist?("D:\\Ruby187\\lib\\ruby\\gems\\1.8\\gems\\rmagick-2.13.1")
  gem "rmagick",  :require => 'RMagick'#, :path => "D:\\Ruby187\\lib\\ruby\\gems\\1.8\\gems\\rmagick-2.13.1"
else
  gem "rmagick",  :require => 'RMagick'
end

gem "gruff"

gem "pdfkit"
gem "google_charts"



gem "data_table",:require => false
gem "acts_as_audited", "2.0.0"

#gem "will_paginate"
#gem "kaminari"
#gem "haml"

#gem "wizardly_gt" , :require => 'wizardly'


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  #gem 'minitest'
  #gem 'mini_backtrace'
  gem 'autotest'
  gem 'autotest-rails-pure'
  #gem 'autotest-growl'
  gem 'spork', '~> 0.9.0.rc'
  gem 'spork-testunit'

  gem 'guard-test'
  #gem 'bundler', '1.0.7'
#   gem 'webrat'
end
#group :production do
#  gem 'bundler','1.0.18'
#end
group :development do
  gem 'rails-dev-boost'
  gem "mongrel", "~> 1.2.0.pre2"
  gem "nifty-generators"
end

gem "pg","0.13.2"

if File.exists?("E:\\rails-project\\rails_kindeditor")
  gem 'rails_kindeditor', :path=>"E:\\rails-project\\rails_kindeditor"
else
  gem 'rails_kindeditor', :git=>"git://github.com/femto/rails_kindeditor.git"
end


group :production do
  if File.exists?("/dev/null")
    gem "thin"
    gem "unicorn"
  else
    gem "mongrel", "~> 1.2.0.pre2"
  end
end
