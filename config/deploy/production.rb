set :user , "tdev"
server "rand.tripledub.co.uk", :app, :web, :db , :primary => true
set :deploy_to , ""
set :deploy_env, 'production'
set :rails_env, "production"

