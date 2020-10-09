# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Json Web tokens
gem 'jwt'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# Annotate classes with schema and routes info
gem 'annotate'
# Business logic
gem 'interactor-rails'
# API Authorization
gem 'action_policy-graphql'
# API
gem 'graphql'

group :development, :test do
  # Pry with Rails support
  gem 'pry-rails'
  # Step-by-step debugging and stack navigation - step, next, continue, finish, break
  gem 'pry-byebug'
  # Start a pry session whenever something goes wrong - try-again, play -l 5
  gem 'pry-rescue'
  # Browse Ruby documentation inside pry
  gem 'pry-doc'
  # Rspec with Rails support
  gem 'rspec-rails'

  # ENV variables
  gem 'dotenv-rails'

  # Coding style
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'graphiql-rails', group: :development
