class Declination < ActiveRecord::Base
  
  belongs_to :person, :foreign_key => "created_by"
  
  def to_s
    reason
  end
  
end
