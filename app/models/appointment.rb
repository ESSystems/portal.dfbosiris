class Appointment < ActiveRecord::Base
  self.inheritance_column = :ruby_type

  STATE = %w[new confirmed booked closed rejected deleted]

  belongs_to :referral
  belongs_to :person
  belongs_to :referral_reason
  belongs_to :diary
  belongs_to :attendance

  scope :overlapping_dates_for_diary, lambda { |diary_id, from_date, to_date|
    all(:conditions => ["diary_id = ? and ? < to_date and from_date < ?", diary_id, from_date, to_date], :from => "#{quoted_table_name} USE INDEX(diary_id_to_date_from_date_index)")
  }

  def confirm
    update_attribute(:state, :confirmed)
  end

  def confirmed?
    state == "confirmed"
  end

  def deleted?
    state == "deleted"
  end

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
    appointments = Appointment.where("id <> #{self.id}").overlapping_dates_for_diary(self.diary_id, from_date, to_date)
    !appointments.empty?
  end

  def new?
    state == "new"
  end

  def soft_delete reason
    if self.from_date > Time.now && self.to_date > Time.now
      self.state = "deleted"
      self.deleted_by = User.current.person_id
      self.deleted_on = DateTime.now
      self.deleted_reason = reason
      self.save
    end
  end
end
