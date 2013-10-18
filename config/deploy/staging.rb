set :user , "develop"
server "887.106.255.184", :app, :web, :db , :primary => true
set :deploy_to , "/var/www/vhosts/develop.essystems.co.uk/subdomains/cmx"
set :deploy_env, 'staging'
set :rails_env, "staging"

