class ReferralObserver < ActiveRecord::Observer
	def after_save(model)
		# Make private any previous attendances
		if model.private_was == false && model.private_changed?
			attendances = Appointment.select("attendance_id").where("referral_id = #{model.id}").all
			attendances.each do |a|
				attnd = Attendance.find a.attendance_id
				attnd.update_attribute "no_work_contact", "Y"
			end
		end

		if model.state_changed? && model.state_change[1] == "canceled"
			appointments = Appointment.where("referral_id = #{model.id}").all
			appointments.each do |a|
				a.soft_delete "The referral with case #{model.case_reference_number} was canceled."
			end
		end
	end
end
