class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      if user.track_referrals == "all"
        can :manage, :all
      elsif user.track_referrals == "initiated_and_assigned"
        can [:index, :create], :all
        can [:show, :edit, :update, :new, :autocomplete_person_full_name, :followers_suggestions], Referral do |r|
          r.try(:referrer) == user || r.try(:followers).include?(user)
        end
      end
    end
  end
end
