class StaffMember < ActiveRecord::Base
	self.table_name = "clinic_staff_member"

	belongs_to :person, :foreign_key => :id

	def self.is_staff_member? id
		if find_by_id id
			return true
		end
		return false
	end
end