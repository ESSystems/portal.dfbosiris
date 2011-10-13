class Appointment < ActiveRecord::Base
  belongs_to :referral
  belongs_to :person
  belongs_to :referral_reason
  belongs_to :diary
  
  set_inheritance_column :ruby_type

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
end
