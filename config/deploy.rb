require "bundler/capistrano"
require "capistrano/ext/multistage"
require "rvm/capistrano"

set :stages, %w(production staging ioh-own)
set :default_stage, "staging"

set :use_sudo, false

set :application, "clinicmanagerextension"

set :scm, :git
set :repository, "git@git.assembla.com:clinic-manager-extension.git"
set :deploy_via, :remote_cache

set :branch, "production"

set :rvm_type, :system
set :rvm_ruby_string, "ruby-1.9.2-p318@cmx"

set :bundle_without , [:development , :test, :darwin]

ssh_options[:forward_agent] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :create_shared_paths do
    run "cd #{shared_path}/ ; mkdir downloads/ "
    run "cd #{shared_path}/ ; mkdir config/ "
    run "cd #{shared_path}/ ; mkdir -p public/system/"
  end

  task :restart, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_database_yaml do
    run "cd #{release_path}/config; ln -s #{shared_path}/config/database.yml database.yml"
  end

  task :symlink_downloads_path do
    run "cd #{release_path}; ln -s #{shared_path}/downloads downloads"
  end

  task :symlink_system_path do
    run "cd #{current_path}/public; rm -rf system; ln -s #{shared_path}/public/system system"
  end
end

after "deploy:setup" , "deploy:create_shared_paths"
after "deploy:symlink", "deploy:symlink_system_path"
before "deploy:finalize_update" , "deploy:symlink_database_yaml"
after "deploy:finalize_update", "deploy:symlink_downloads_path"

after "deploy", "deploy:migrate"

require './config/boot'
