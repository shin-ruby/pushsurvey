# -*- encoding : utf-8 -*-
Proedm::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = true

  # Enable serving of images, stylesheets, and javascripts from an asset server
  #config.action_controller.asset_host = "http://assets.example.com"
  #config.action_controller.asset_host = "http://localhost:3000/"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = {:host => 'www.pushsurvey.com'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  if ENV['SENDGRID_USERNAME'] #in heroku environment
    config.action_mailer.smtp_settings = {
      :address => 'smtp.sendgrid.net',
      :port => '25',
      :domain =>ENV['SENDGRID_DOMAIN'],
      :authentication => :plain,
      :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
  }
  else
    config.action_mailer.smtp_settings = {
        :address => 'smtp.sendgrid.net',
        :port => '25',
        :user_name => 'app1951006@heroku.com',
        :password => "qityv0el",
        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain => "heroku.com" # the HELO domain provided by the client to the server
    }

  end

  # Enable threaded mode
  config.threadsafe!

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false


  config.assets.precompile += %w( application-all.css application-print.css application-ie.css active_admin.css active_admin.js kindeditor/lang/en.js kindeditor/lang/zh_CN.js
    kindeditor/themes/default/default.css kindeditor/plugins/image/image.js kindeditor/plugins/flash/flash.js kindeditor/plugins/filemanager/filemanager.js kindeditor/plugins/table/table.js
    kindeditor/plugins/media/media.js kindeditor/plugins/insertfile/insertfile.js canvas.js pw.js pw.js.erb interfaces/default/style.css)

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
end

Sass::Plugin.options[:never_update] = true
