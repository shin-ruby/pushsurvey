require 'net/https'

class SendGridApi
  class << self
    attr_accessor :api_user,:api_key
  end
  def self.request(_module, action, options={})
      site = Net::HTTP.new("sendgrid.com", 443)
      site.use_ssl = true
      url = "/api/#{_module}.#{action}.json?api_user=#{api_user}&&api_key=#{api_key}"
      if options.present?
         url_param = params.map {|key, value| "key=#{CGI::escape(value.to_s)}"}.join("&")
         url += "&#{url_param}"
      end
      response = site.get url
      ActiveSupport::JSON.decode response.body
  end
end