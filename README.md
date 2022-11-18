# Mark 4:23
A simple whitelabel podcast-as-a-service

* Multiple podcasts
* Users can have access to multiple podcasts
* Podcasts are published on an s3-compatible storage
* Email notifications when new episodes are published

## Testing
To run the code tests: `rails test`

To run the browser-based tests: `rails test:system`

## Setup
Clone this repository and run `bundle install` to install all dependencies.

When the application is started, no users are defined. To create an admin account: `rails db:seed`. If an admin account is already present, this command will reset the password.

Environment: 
* APP_DOMAIN should point to your domain name. Default: mark423.com
* PODCAST_HOST should point to the storage where your podcast storage is. Default: https://`APP_DOMAIN`/podcasts
* RAILS_ENV should be production


## Jobs
`RAILS_ENV=development bundle exec rake jobs:work`

## THANKS

* Icons from [svgrepo](https://www.svgrepo.com)
* 