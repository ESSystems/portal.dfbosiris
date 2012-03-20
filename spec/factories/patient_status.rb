Factory.define :patient_status do |f|
  f.status Forgery(:lorem_ipsum).words(3)
end