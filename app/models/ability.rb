class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
      can :index, :all

      can [:create, :autocomplete_person_full_name, :followers_suggestions], :all do |m|
        !user.read_only_access?
      end

      # Referral abilities
      can :accept_declination_and_close, Referral do |r|
        !user.read_only_access? && r.try(:referrer) == user
      end

      can :update, Referral do |r|
        !user.read_only_access? && r.try(:referrer) == user && !r.try(:canceled?)
      end

      can :cancel, Referral do |r|
        !user.read_only_access? && !r.try(:appointments).empty? &&
          r.try(:referrer) == user && !r.try(:canceled?)
      end

      can :destroy, Referral do |r|
        !user.read_only_access? && r.try(:appointments).empty? &&
          r.try(:referrer) == user && r.try(:state) == 'new'
      end

      can :show, Referral do |r|
        r.try(:referrer) == user
      end

      if user.track_referrals == "all"
        can :show, Referral do |r|
          r.try(:private) == false || r.try(:private) == true && r.try(:referrer) == user
        end
      elsif user.track_referrals == "initiated_and_assigned"
        can :show, Referral do |r|
          r.try(:referrer) == user || r.try(:followers).include?(user) && r.try(:private) == false
        end
      end

      # Person abilities
      can [:show], Person
      can [:edit, :update], Person do |p|
        !user.read_only_access? && p.try(:referrer) == user
      end
      can [:destroy], Person do |p|
        !user.read_only_access? && Appointment.find_by_person_id(p.id).nil? && Referral.find_by_person_id(p.id).nil? && p.try(:referrer) == user
      end

      # User abilities
      can [:dashboard, :edit, :update], User

      # Notification abilities
      can [:index, :read], Notification

      # Appointment abilities
      can [:confirm_appointment, :calendar_data, :calendar_update_date], Appointment do |a|
        a.try(:referral).referrer == user && !a.try(:deleted?)
      end
    end
  end
end
