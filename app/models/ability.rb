class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    end

    if user.moderator?
      can :manage, [Subject, Lesson, Video], user_id: user.id
    end
  end
end
