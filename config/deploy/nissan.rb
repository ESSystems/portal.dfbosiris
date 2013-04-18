set :user , "portal"
server "87.106.136.226", :app, :web, :db , :primary => true
set :deploy_to , "/var/www/vhosts/osirisnissan.co.uk"
set :deploy_env, 'production'
set :rails_env, 'production'
