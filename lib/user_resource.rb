module UserResource #or called UserScope? everyone has user_id includes this module
  def can_be_viewed(user)
    user && (user.id == self.user_id || user.admin?)
  end
  def set_user
    self.user_id = Thread.current[:user_id]
  end
  def self.append_features(base)
    super
    puts "#{base.inspect} included"
    base.send(:belongs_to, :user)

    arel = base.arel_table


    base.send(:scope, :with_user, proc{
      if Thread.current[:user_id]
        base.send(:where, "1=1")
      else
        base.send(:where,arel[:user_id].eq(Thread.current[:user_id]))
      end

    }) #should implement user_id == 3
    base.send(:before_save, :set_user)
    #base.send(:default_scope, proc {base.send(:where,:user_id=>3)})
  end
  def self.debug
    puts 3
  end

end