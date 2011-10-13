source 'http://rubygems.org'



gem 'rails', '3.0.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'json'
gem 'roo'
gem 'zip'
gem 'nokogiri'
gem 'pony'
gem 'fastercsv'

gem 'devise'
gem 'jquery-rails'
gem 'activeadmin'
gem "cancan"

#gem 'validation_group', :git=>'git://github.com/akira/validationgroup.git'
#gem 'grouped_validations'
gem 'delayed_job'

gem "airbrake"

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
  gem 'mongrel'
  gem "nifty-generators"
end
