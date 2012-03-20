Factory.define :diary do |d|
  d.name Forgery(:name).full_name
  d.appointment_length 0
  d.available_days 0
  d.color_id 21
  d.start_time "00:00:00"
  d.end_time "00:00:00"
  d.owner_id 0
end