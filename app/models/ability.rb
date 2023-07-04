class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Category, author_id: user.id
    can :manage, Purchase, author_id: user.id
  end
end
