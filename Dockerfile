FROM ruby:3.2-bullseye

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENV RAILS_ENV=production

EXPOSE 3000
CMD ["/bin/bash","-c","rm -f /usr/src/app/tmp/pids/server.pid ; bundle exec rails server -b 0.0.0.0 -p 3000 2>&1 | tee /usr/src/app/log/stdout.log"]

RUN apt-get update && apt-get install -y nodejs vim imagemagick \ 
    texlive texlive-xetex fonts-freefont-ttf fonts-lmodern lmodern \
    python2 --no-install-recommends && rm -rf /var/lib/apt/lists/* 
    
# ahhhhhh python 2 is so old the symlinks are broken and have to be set manually
RUN ln -sf /usr/bin/python2 /usr/bin/python

# Clean up apt cache now
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy files
COPY . /usr/src/app
 
# Configure bundler path and exclude development/test gems
RUN bash -lc 'bundle config set --local path vendor/bundle'
RUN bash -lc 'bundle install --jobs=$(nproc) --retry=3 --without development test'

#RUN bundle exec whenever --update-crontab

