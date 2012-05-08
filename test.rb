# -*- encoding : utf-8 -*-
require 'rubygems'
require "rest-client"
def make_cookies(cookies)
    cookies.to_a.map{|x|x.join("=")}.join(";")
end

response = RestClient.post("http://phpruby.myjetbrains.com/youtrack/rest/user/login?login=femto&password=fffff",{})
cookie = make_cookies(response.cookies)
r = RestClient.post("http://phpruby.myjetbrains.com/youtrack/rest/admin/project/phpruby/subsystem/String?isDefault=true",{},
    :Cookie=>cookie)
      #:Cookie=>response.cookies)
puts r
