class Person < ActiveRecord::Base
  
  has_one :patient
  
end
