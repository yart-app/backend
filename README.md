# README
![Travis CI Status](https://travis-ci.com/EhsanZ/yart.svg?branch=master)
[![codebeat badge](https://codebeat.co/badges/ca5da6da-5a47-48d9-b7c3-bd61ceebe3e4)](https://codebeat.co/projects/github-com-ehsanz-yart-feature-allow_users_to_manage_projects)
## Description:
A community for yarn art lovers, where crocheters and knitters can share their work, their patterns, thier questions and ideas.

## Project state:
Under establishment.

## Contribution state:
Contribution to this project will be always welcoming, however right now we need your contribution on ideas more than technical stuff.

## Technical details:

### Ruby version:
2.4.2

### System dependencies:
* Devise.

### Configuration:
...

### Database creation:
The used database is PostgreSQL so all you need is to run `rails db:migrate` in order to create the db.

### Seeding database with demo data:
`rake db:seed` or `docker exec -it yart-backend-app-1 sh -c "rake db:seed"`

### Database initialization:
...

### How to run the test suite:
`bundle exe rspec`

### To run the project using Docker:
Make a copy of `.env.example` as `docker.env` then run `docker-compose up`

### To run the test suite using Docker:
Connect to the app container `docker exec -it yart_app_1 /bin/bash` then run `RAILS_ENV=test bundle exec rspec`
