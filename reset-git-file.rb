require 'fileutils'
files=%w(       app/controllers/push1s_controller.rb
       app/controllers/pushes_controller.rb
       app/helpers/push1s_helper.rb
       app/helpers/pushes_helper.rb
       app/models/push.rb
       app/models/push1.rb
       db/migrate/20111007113352_create_pushes.rb
       db/migrate/20111007114241_create_push1s.rb
       test/fixtures/push1s.yml
       test/fixtures/pushes.yml
       test/functional/push1s_controller_test.rb
       test/functional/pushes_controller_test.rb
       test/unit/helpers/push1s_helper_test.rb
       test/unit/helpers/pushes_helper_test.rb
       test/unit/push1_test.rb
       test/unit/push_test.rb)
files.each do |file|
  FileUtils.rm(file, :force=>true)
end
