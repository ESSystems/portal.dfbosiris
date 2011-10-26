class Employee < ActiveRecord::Base
  set_table_name "nemployees"
  
  belongs_to :person
  belongs_to :client
  belongs_to :department
  belongs_to :job_class
  belongs_to :organisation, :foreign_key => "client_id"
end
