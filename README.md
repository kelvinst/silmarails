# silmarails

Silmarails is a warehouse for templates and initial configurations for
brand new rails project with the minimum needed for a quick development
environment.

## Pre requisites

So, there is no explicit pre requisite to install this gem and use it in your
rails project. But I actually recommend to be running with `rails ~> 4.2`,
`ruby ~> 2.2`, `postgres` (any version) aaaaaaand, if you are creating your
project now, to create it with the following command:

```bash
rails new my_project -T -d postgresql
```

That's it!

## Install

To intall this project, first, you need to add the following to your Gemfile:

```ruby
gem 'silmarails'
gem 'kaminari'
gem 'responders'
gem 'simple_form'
# Uncomment this and remove bootstrap if you are using foundation
# gem 'foundation-rails'

group :test do
  gem "rspec"
  gem "rspec-rails"
  gem "capybara"
  gem "database_cleaner"
  gem 'factory_girl_rails'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end
```

Then:

```bash
bundle install
```

The other gems are not hard dependencies, but we have some templates defined
that need them to work correctly, please check their installation guides
individually. If you are not so interested in reading everyone, here comes a
list of commands you'll probably need to execute:

```bash
rails g kaminari:config
rails g rspec:install
rails g responders:install

# if you're using bootstrap
rails g kaminari:views bootstrap3
rails g simple_form:install --bootstrap

# if you're using foundation
rails g foundation:install
rails g kaminari:views foundation5
rails g simple_form:install --foundation
```

And finally:

```bash
# if you're using bootstrap
rails g silmarails:install --framework=bootstrap

# if you're using foundation
rails g silmarails:install --framework=foundation
```

This will copy all the default templates into your rails project, and may have
conflicts with other gems. If so, just diff them and choose which one you
prefer.

It's important to remember that this needs to be recopied everytime there is a
update on them.

## How to update

Well, that's a long story. Depends of course on how many things are you updating
at once, but I would recommend update all of them separetedly. So:

```bash
bundle update silmarails
```

After that, you'll be able to just:


```bash
rails g silmarails:install
```

This, of course, can have changes dependeding on which is the update and take
attention to your changes to the templates you've copied. Choose wisely if you
want or not the new version. :stuck_out_and_tongue:

## Recommended configuration

Follows some recommended configuration for your application if you are using
silmarails:

```
<app/assets/stylesheets/application.css>
# add the following lines to ignore the scaffolds file and import the needed
# bootstrap (if you are not using foundation, of course)
 *= stub scaffolds
 *= require bootstrap

<app/assets/javascripts/application.js>
# add the following lines to import the needed bootstrap (if you are not using
# foundation, of course)
//= require bootstrap
//= require magic_view

# then, at the end of file, add the following line to init the magic_view code
//= require magic_view/init

<config/application.rb>
# add the following lines to configure the generators properly
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        model_specs: false,
        helper_specs: false
      g.fixture_replacement :factory_girl
      g.factory_girl dir: "spec/factories"
    end

<spec/rails_helper.rb>
# uncomment the following line to require the needed support files (one of them
# is copied on the silmarails installations)
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# then change the value of the following config to false (the raise of the code below
# is granting this will be always that way and explaining why it's needed, but
# I'm warning you one more tim: DO THIS AND DON'T REMOVE THAT RAISE!!!!!!)
  config.use_transactional_fixtures = false

# and finally add the following lines to configure the database cleaner for your
# rspec tests (put them inside the
  config.before(:suite) do
    # don't remove this raise for the sake of God!!!
    if config.use_transactional_fixtures?
      raise(<<-MSG)
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
      MSG
    end
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
```
