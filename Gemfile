source 'http://rubygems.org'

gem 'rails', "~> 3.1.0"

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'formtastic'
gem 'rails3-jquery-autocomplete'
gem 'paperclip'
gem "therubyracer", "~> 0.9.8"

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'forgery'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'

  # Pretty printed test output
  gem 'turn', '< 0.8.3'

  gem 'simplecov'

  if RUBY_PLATFORM.downcase.include?("darwin")
  	gem 'rb-fsevent'
  	#gem 'growl_notify'
  end
end
