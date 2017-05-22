# OD-OT

[![Build Status](https://travis-ci.org/k1r8r0wn/od-ot.svg?branch=master)](https://travis-ci.org/k1r8r0wn/od-ot)
[![Code Climate](https://codeclimate.com/github/k1r8r0wn/od-ot/badges/gpa.svg)](https://codeclimate.com/github/k1r8r0wn/od-ot)
[![Test Coverage](https://codeclimate.com/github/k1r8r0wn/od-ot/badges/coverage.svg)](https://codeclimate.com/github/k1r8r0wn/od-ot/coverage)
[![Issue Count](https://codeclimate.com/github/k1r8r0wn/od-ot/badges/issue_count.svg)](https://codeclimate.com/github/k1r8r0wn/od-ot)
[![Dependency Status](https://gemnasium.com/badges/github.com/k1r8r0wn/od-ot.svg)](https://gemnasium.com/github.com/k1r8r0wn/od-ot)

## About

Simple to-do rails application using Test-Driven Development with RSpec and Capybara. You can find out the working version [here](https://od-ot.herokuapp.com).

## Getting started

1. Create local `config/database.yml`(it stores the db configs) & edit it;

  ```bash
    cp config/database.yml.example config/database.yml
  ```

2. Create `docker-compose.override.yml` file & copy code from `docker-compose.development.yml`;

3. Create local `.env` file to store all env. variables:

  ```bash
    cp .env.example .env
  ```

4. Install [docker](https://docs.docker.com/engine/installation/) & [docker-compose](https://docs.docker.com/compose/install/) if you haven't got them yet and then run:

  ```bash
    docker-compose build
  ```

5. Create new db and run migrations inside docker's `web` container:

  ``` bash
    docker-compose run web rails db:create && docker-compose run web rails db:migrate
  ```

6. Run the project:

  ```bash
    docker-compose up
    docker-compose up -d # Without logs
  ```

Great, now Od-ot app should be running on `localhost:3000`.

## Contributing

1. Fork this repository;
2. Clone the project;
3. Bug reports and pull requests(PR) are welcome on GitHub at [https://github.com/k1r8r0wn/od-ot](https://github.com/k1r8r0wn/od-ot). Just create new branch & add PR to this origin repository.

## License

The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
