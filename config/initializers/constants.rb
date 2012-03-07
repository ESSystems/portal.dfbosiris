require 'socket'

case Socket.gethostname
when "csmac.local"
  OSIRIS_SERVER_NAME = "cm2.local"
when "rand.tripledub.co.uk"
  OSIRIS_SERVER_NAME = "cm2.develop.tripledub.co.uk"
when "IS-16273"
  OSIRIS_SERVER_NAME = "osiris.clinic-ms.co.uk"
end
