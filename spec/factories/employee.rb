Factory.define :employee do |f|
  f.association :person
  f.association :client
  f.association :department
  f.association :job_class
  f.sap_number Forgery(:basic).number :at_least => 7, :at_most => 7
end