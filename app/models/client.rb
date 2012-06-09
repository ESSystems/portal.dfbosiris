class Client < ActiveRecord::Base
  self.table_name = "client"
  self.primary_key = :ClientID
  
end
