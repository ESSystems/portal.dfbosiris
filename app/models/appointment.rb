class Appointment < ActiveRecord::Base
  belongs_to :referral
  belongs_to :person
  belongs_to :referral_reason
  set_inheritance_column :ruby_type

  # getter for the "type" column
  def device_type
    self[:type]
  end

  # setter for the "type" column
  def device_type=(s)
    self[:type] = s
  end
end
