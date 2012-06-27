class Appointment < ActiveRecord::Base
  self.inheritance_column = :ruby_type

  STATE = %w[new confirmed booked closed rejected deleted]

  belongs_to :referral
  belongs_to :person
  belongs_to :referral_reason
  belongs_to :diary
  belongs_to :attendance

  scope :overlapping_dates_for_diary, lambda { |diary_id, from_date, to_date|
    where("diary_id = ? and ? < to_date and from_date < ?", diary_id, from_date, to_date)
  }

  # getter for the "type" column
  def device_type
    self[:type]
  end

  # setter for the "type" column
  def device_type=(s)
    self[:type] = s
  end

  def display_date
    "#{from_date.to_date} from #{from_date.to_s(:hours_and_minutes)} to #{to_date.to_s(:hours_and_minutes)}"
  end

  def is_overlapping_another(from_date, to_date)
    appointments = Appointment.overlapping_dates_for_diary(self.diary_id, from_date, to_date).where("id <> #{self.id}")
    !appointments.empty?
  end

  def confirmed?
    state == "confirmed"
  end

  def new?
    state == "new"
  end

  def confirm
    update_attribute(:state, :confirmed)
  end
end
