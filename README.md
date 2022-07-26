# README

This is a small application demo to visualize some metrics. 

Things you may want to cover:

* Ruby version: 3.1.2

* Bundler version: 2.3.18

* System dependencies: sqlite3, nodejs, npm, yarn, foreman

* Configuration

* Database creation: `rails db:create`

* Database migration: `rails db:migrate`

* Database seeds: `rails db:seeds`

* How to run the test suite: `rspec spec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions:
  - build assets
  - execute the rails application

* Running the application:
  - development `foreman start -f Profile.dev`

## Development:

Use `bundle install` to download all dependencies and start coding.

* Using rubocop to follow code format standars. https://github.com/rubocop/rubocop-rails
* Using rspec for testing. https://relishapp.com/rspec/rspec-rails/v/5-1/docs
* Using FactoryBot for testing with factories: https://github.com/thoughtbot/factory_bot_rails
* Can use Guard `bundle exec guard` to gravitate towards red-green development flow.
* Using vite as the assets pipeline: https://vite-ruby.netlify.app/
* Using vue3 as the front-end framework: https://vuejs.org/

### Business logic
Using business/Interactors logic gem [ActionLogic](https://github.com/rewinfrey/ActionLogic)

