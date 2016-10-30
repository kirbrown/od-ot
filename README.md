# OD-OT

[![Build Status](https://travis-ci.org/k1r8r0wn/od-ot.svg?branch=master)](https://travis-ci.org/k1r8r0wn/od-ot)
[![Code Climate](https://codeclimate.com/github/k1r8r0wn/od-ot/badges/gpa.svg)](https://codeclimate.com/github/k1r8r0wn/od-ot)
[![Test Coverage](https://codeclimate.com/github/k1r8r0wn/od-ot/badges/coverage.svg)](https://codeclimate.com/github/k1r8r0wn/od-ot/coverage)
[![Issue Count](https://codeclimate.com/github/k1r8r0wn/od-ot/badges/issue_count.svg)](https://codeclimate.com/github/k1r8r0wn/od-ot)
[![Dependency Status](https://gemnasium.com/badges/github.com/k1r8r0wn/od-ot.svg)](https://gemnasium.com/github.com/k1r8r0wn/od-ot)

## About

Simple to-do rails application using Test-Driven Development with RSpec and Capybara. You can find out the working version [here](https://od-ot.herokuapp.com).

## Getting started

1. Install ruby & choose the project's ruby version (you can simply use [RVM](https://rvm.io/) to do that):

  ```bash
    rvm install ruby-2.3.1
  ```
  ```bash
    use ruby-2.3.1
  ```
  
2. Create gemset & switch to it (if you use [RVM](https://rvm.io/)):
  
  ```bash
    rvm gemset od-ot
  ```
  ```bash
    rvm use od-ot
  ```
  
3. Install [Bundler](http://bundler.io/):

  ```bash
    gem install bundler
  ```
  
4. Install gems:

  ```bash
    bundle install
  ```

5. Create local `config/database.yml`(it stores the db configs);
  
  ```bash
    cp config/database.yml.sample config/database.yml
  ```

6. Create new db and run migrations:

  ``` bash
    rake db:create && rake db:migrate
  ```

7. Also prepare the test db:

  ```bash
    rake db:test:prepare
  ```

8. Great! You're ready to run the app. Start rails server:

  ```bash
    rails s
  ```

## Contributing

1. Fork this repository;
2. Clone the project;
3. Bug reports and pull requests(PR) are welcome on GitHub at [https://github.com/k1r8r0wn/od-ot](https://github.com/k1r8r0wn/od-ot). Just create new branch & add PR to this origin repository.

## License

The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
