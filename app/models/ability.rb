class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      # can :perform, SortAndFilterData
    end
  end
end
