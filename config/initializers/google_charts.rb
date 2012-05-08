# -*- encoding : utf-8 -*-
begin
  ActionView::Base.send :include, GoogleCharts::Helpers::ActionView
rescue LoadError
  $stderr.puts "Skipping GoogleCharts plugin. `gem install actionpack` and try again."
end
