class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    end

    if user.moderator?
      # TODO: allow to modify only his/her own content
      can :manage, :all
      can :read, :all
    end
  end
end
