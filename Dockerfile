FROM ruby:2.5

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
COPY cloud_status_alerter.rb .
RUN gem install bundler --no-document && bundle install

CMD ["bundle", "exec", "./cloud_status_alerter.rb"]
