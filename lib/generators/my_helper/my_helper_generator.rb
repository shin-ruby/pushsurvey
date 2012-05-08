# -*- encoding : utf-8 -*-
class Rails::MyHelperGenerator < Rails::Generators::NamedBase
     def create_helper_file
    create_file "app/helpers/#{file_name}_helper.rb", <<-FILE
module #{class_name}Helper
  attr_reader :#{plural_name}, :#{plural_name.singularize}
end
    FILE
     end
  hook_for :test_framework, :as => :helper
end
