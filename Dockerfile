FROM ruby:2.4.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENV RAILS_ENV=production

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]

RUN apt-get update && apt-get install -y nodejs imagemagick texlive --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY ./ /usr/src/app
RUN bundle install
