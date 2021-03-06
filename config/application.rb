# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Proedm
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
     config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    config.middleware.use "PDFKit::Middleware" , :print_media_type => true

     # Enable the asset pipeline
     config.assets.enabled = true

     # Version of your assets, change this if you want to expire all your assets
     config.assets.version = '1.0'

     config.assets.initialize_on_precompile = false

  end
end

#ENV['SENDGRID_USERNAME'] = "app1864066@heroku.com"
#ENV['SENDGRID_PASSWORD'] =  "kle97ehz"
#remeber to setup sendgrid account and set postback url

  PDFKit.configure do |config|
    if File.exist? "d:\\wkhtmltopdf\\wkhtmltopdf.exe"
     config.wkhtmltopdf = "d:\\wkhtmltopdf\\wkhtmltopdf.exe"
    else
     config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
    end
    # config.default_options = {
    #   :page_size => 'Legal',
    #   :print_media_type => true
    # }
    # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
  end

if !File.exists?("/dev/null")
  Pathname::SAME_PATHS = if File::FNM_SYSCASE.nonzero?
                           proc {|a, b| true}
                         else
                           proc {|a, b| a == b}
                         end
end

Time::DATE_FORMATS[:default]=Time::DATE_FORMATS[:db]
EMAIL_REGEX =/^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

#CarrierWave.configure do |config|
#      config.s3_access_key_id = ENV['S3_KEY']
#      config.s3_secret_access_key = ENV['S3_SECRET']
#      config.s3_bucket = "file0.pushsurvey.com"
#      config.s3_access_policy = :private
#      #config.s3_headers = {"Content-Disposition" => "attachment; filename=foo.jpg;"}
#end
