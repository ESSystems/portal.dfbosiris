set :user , "portal"
server "82.165.137.62", :app, :web, :db , :primary => true
set :deploy_to , "/var/www/vhosts/portal.dfbosiris.co.uk"
set :deploy_env, 'production'
set :rails_env, 'production'
