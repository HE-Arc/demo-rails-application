source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Look and feel using Zurb Foundation
gem 'foundation-rails', '~> 6.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Coding style
gem 'rubocop', require: false

gem 'tzinfo-data', '~> 1.2016.5'

# Automagic administration.
gem 'activeadmin', github: 'activeadmin'
# Pre-Rails 5 support for activeadmin.
gem 'inherited_resources', github: 'activeadmin/inherited_resources'

# Automagic attached files
gem 'paperclip', '~> 5.0'
# Soft deletion
gem 'soft_deletion', '~> 0.7'

# Use Puma as the app server
gem 'puma', '~> 3.6'
# Use Redis Rails to set up a Redis back-end.
gem 'redis-rails', '~> 5.0.0'
# Use Sidekiq as a background job.
gem 'sidekiq', '~> 4.1'
# Sidekiq's web interface requires Sinatra
gem 'sinatra', git: 'https://github.com/sinatra/sinatra'
# Sinatra 2 requires Rack protection
gem 'rack-protection', git: 'https://github.com/sinatra/rack-protection'

# Enable the usage of namespace in redis.
gem 'redis-namespace'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Deployment using capistrano
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
end

group :test do
  # Brings assigns and assert_template in controller and integration tests.
  gem 'rails-controller-testing'
end
