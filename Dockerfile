FROM ruby:3.1.2-alpine
RUN apk update && apk add --no-cache build-base nodejs postgresql-dev postgresql-client vips supervisor ffmpeg
RUN gem update --system
RUN  adduser -D app
USER app
WORKDIR /app
COPY --chown=app Gemfile* .
RUN bundle config  --local path 'vendor/bundle' \
    && bundle install

COPY --chown=app . .
RUN RAILS_ENV=production bin/rails assets:precompile
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENTRYPOINT ["/usr/bin/supervisord"]
EXPOSE 3000
