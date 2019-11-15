FROM ruby:2.6.5

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
COPY providers/ ./providers/
COPY cloud_status_alerter.rb provider.rb ./
RUN gem install bundler --no-document && bundle install

CMD ["bundle", "exec", "./cloud_status_alerter.rb"]
