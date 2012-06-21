class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      can [:index, :new, :create, :autocomplete_person_full_name, :followers_suggestions], :all

      can [:edit, :update, :show, :cancel, :accept_declination_and_close], Referral do |r|
        r.try(:referrer) == user
      end

      if user.track_referrals == "all"
        can [:show], Referral do |r|
          r.try(:private) == false || r.try(:private) == true && r.try(:referrer) == user
        end
      elsif user.track_referrals == "initiated_and_assigned"
        can [:show], Referral do |r|
          r.try(:referrer) == user || r.try(:followers).include?(user) && r.try(:private) == false
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

      can [:confirm_appointment, :calendar_data, :calendar_update_date], Appointment do |a|
        a.try(:referral).referrer == user
      end
    end
  end
end
