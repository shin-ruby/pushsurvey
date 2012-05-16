# -*- encoding : utf-8 -*-
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET']
  }
  config.fog_directory  = 'file.pushsurvey.com'
  config.fog_host       = 'http://file.pushsurvey.com.s3.amazonaws.com'
  config.fog_attributes = { 'Cache-Control'=>'max-age=315576000' }
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  config.fog_public     = false                                   # do
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.max_file_size     = 5.terabytes
end
