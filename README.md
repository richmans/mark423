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
* APP_URL should point to your domain name. Default: https://mark423.com
* PODCAST_HOST should point to the storage where your podcast storage is. Default: `APP_URL`/podcasts
* RAILS_ENV should be production
* S3_ACCESS_KEY your storage access key
* S3_SECRET_KEY your storage password
* S3_BUCKET your storage bucket
* S3_ENDPOINT your storage endpoint
* DATABASE_URL your database url
* SMTP_USER_NAME your mail sender username
* SMTP_PASSWORD your mail sender password
* SMTP_DOMAIN The HELO domain to give to your smtp sender
* SMTP_ADDRESS the address (ip/dns) of your smtp sender
* SMTP_PORT the port of your smtp mailsender (587)
* SMTP_AUTHENTICATION The authentication method for smtp (plain)


## Jobs
`RAILS_ENV=development bundle exec rake jobs:work`

## Scripts
`bin/rails mark423:import PODCAST URL` to import a remote podcast into your platform

## THANKS

* Icons from [svgrepo](https://www.svgrepo.com)
* 