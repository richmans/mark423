FROM ruby:3.1.2-alpine
RUN apk update && apk add build-base nodejs postgresql-dev postgresql-client vips supervisor ffmpeg
RUN gem update --system
RUN  adduser -D app
WORKDIR /app
COPY Gemfile* .
RUN bundle config  --local path 'vendor/bundle' \
    && bundle install

COPY . .
RUN RAILS_ENV=production bin/rails assets:precompile
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chown -R app /app
USER app
ENTRYPOINT ["/usr/bin/supervisord"]
EXPOSE 3000
