# -*- encoding : utf-8 -*-
module ApplicationHelper
  def tabs(tabs)
    result = []
     tabs.each do |tab|
       if tab[2] && ((tab[2].is_a?(String) && tab[2] == controller_name) || (tab[2].is_a?(Proc) && tab[2].call)) #has specification
         link_name = "<span class='current'>#{tab[0]}</span>".html_safe
         result << "<li>#{link_to link_name, tab[1]}</li>"
       else
         result << "<li>#{link_to tab[0], tab[1]}</li>"
       end
     end
   result.join("\n").html_safe
  end
end
