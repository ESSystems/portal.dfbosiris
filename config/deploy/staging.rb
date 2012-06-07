set :user , "tdev"
server "rand.tripledub.co.uk", :app, :web, :db , :primary => true
set :deploy_to , "/var/www/vhosts/develop.tripledub.net/subdomains/cmx"
set :deploy_env, 'staging'
set :rails_env, "staging"

