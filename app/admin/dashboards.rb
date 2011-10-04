ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
     section "Recent Push", :priority => 1 do
       table_for  User.all do

       end
     end

     section "Recent User", :priority => 2 do
       table_for  User.all do
           column("email") {|user| link_to user.email,admin_user_path(user) }

       end
     end

     section "Recent AddressBook", :priority => 3 do
       table_for  User.all do

       end
     end

     section "Recent Design", :priority => 4 do
       table_for  Design.all do
          column("name") {|design| link_to design.name,admin_design_path(design) }
       end
     end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
