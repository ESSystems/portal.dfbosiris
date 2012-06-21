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
	end
end
