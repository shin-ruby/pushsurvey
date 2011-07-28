$: << 'test'
#RUBYLIB
AutoRunner
%w[test/unit test/unit/contact_test.rb test/unit/importer_test.rb test/unit/helpers/contacts_helper_test.rb test/functional/contacts_controller_test.rb].each { |f| puts "`testdrb " + f + "`";eval("`testdrb -Itest " + f + "`")}