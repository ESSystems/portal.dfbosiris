class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      can :manage, :all
    end
  end
end
