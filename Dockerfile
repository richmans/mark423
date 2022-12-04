FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libvips ffmpeg supervisor
RUN gem update --system
RUN  useradd -ms /bin/bash app
WORKDIR /app
COPY Gemfile* .
RUN bundle install
COPY . .
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chown -R app /app
USER app
ENTRYPOINT ["/usr/bin/supervisord"]
EXPOSE 3000
