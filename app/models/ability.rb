class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
       if user.admin?
         can [:read,:create,:update,:destroy], :all
         can :start, Push do |object|
             object.date_push.nil?
         end
       else
         can :read, :all do |object|
           !object.is_a?(Push) && object.user_id == user.id
         end
         can :create, :all do |object|
           !object.is_a?(Push)
         end
         can :update,:all do |object|
           !object.is_a?(Push) && object.user_id == user.id
         end
         can :destroy,:all do |object|
           !object.is_a?(Push) && object.user_id == user.id
         end

         can :read, Push do |object|
           object.is_a?(Push) && object.user_id == user.id
         end
         can :create, Push do |object|

         end
         can :update,Push do |object|
           object.is_a?(Push) && object.user_id == user.id
         end
         can :destroy,Push do |object|
           object.is_a?(Push) && object.user_id == user.id
         end

         can :start,Push do |object|
           object.user_id == user.id && object.date_push.nil?
         end


       end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
