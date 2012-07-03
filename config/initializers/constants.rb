if Rails.env.production?
	OSIRIS_SERVER_NAME = "osiris.clinic-ms.co.uk"
elsif Rails.env.staging?
	OSIRIS_SERVER_NAME = "cm2.develop.tripledub.co.uk"
elsif Rails.env.development?
	OSIRIS_SERVER_NAME = "cm2.local"
elsif Rails.env.test?
	OSIRIS_SERVER_NAME = "cm2.local"
end