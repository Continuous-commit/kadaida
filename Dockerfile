FROM ruby:2.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /myrails
WORKDIR /myrails
COPY Gemfile /myrails/Gemfile
COPY Gemfile.lock /myrails/Gemfile.lock
RUN bundle install
COPY . /myrails

RUN rm -f tmp/pids/server.pid

CMD ["rails", "server", "-b", "0.0.0.0"]