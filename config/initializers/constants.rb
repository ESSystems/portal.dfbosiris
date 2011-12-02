require 'socket'

case Socket.gethostname
when "csmac.local"
  OSIRIS_SERVER_NAME = "cm2.local"
when "rand.tripledub.co.uk"
  OSIRIS_SERVER_NAME = "cm2.develop.tripledub.co.uk"
end
