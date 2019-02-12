FROM ruby:2.4

RUN apt-get update && \
      # install postgresql
      apt-get install -y postgresql-client && \
      # install nodejs
      wget -qO- https://deb.nodesource.com/setup_8.x | bash - && \
      apt-get install -y nodejs && \
      # install yarn
      wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && \
      apt-get install yarn && \
      # install bundler
      gem install bundler && \
      # clean up
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# create app folder
RUN mkdir /wwp
WORKDIR /wwp

# install rails dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# install webpack dependencies
COPY package.json yarn.lock ./
RUN yarn
