FROM ruby:2.4.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENV RAILS_ENV=production

EXPOSE 3000
CMD ["/bin/bash","-c","rm -f /usr/src/app/tmp/pids/server.pid ; bundle exec rails server -b 0.0.0.0 -p 3000 2>&1 | tee /usr/src/app/log/stdout.log"]

RUN apt-get update && apt-get install -y nodejs vim imagemagick texlive texlive-xetex fonts-freefont-ttf fonts-lmodern lmodern --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY ./ /usr/src/app
RUN bundle install
