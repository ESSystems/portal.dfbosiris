class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      can [:index, :new, :create], :all
      if user.track_referrals == "all"
        can :manage, Referral
      elsif user.track_referrals == "initiated_and_assigned"
        can [:edit, :update, :cancel, :autocomplete_person_full_name, :followers_suggestions], Referral do |r|
          r.try(:referrer) == user
        end
        can [:show], Referral do |r|
          r.try(:referrer) == user || r.try(:followers).include?(user)
        end
      end
      can [:show], Person
      can [:edit, :update], Person do |p|
        p.try(:referrer) == user
      end
      can [:destroy], Person do |p|
        Appointment.find_by_person_id(p.id).nil? && Referral.find_by_person_id(p.id).nil? && p.try(:referrer) == user 
      end
      can [:dashboard, :edit, :update], User
      can [:index, :read], Notification
    end
  end
end
