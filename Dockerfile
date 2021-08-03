FROM ruby:3.0.2

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
COPY providers/ ./providers/
COPY aws_provider.rb cloud_status_alerter.rb provider.rb ./
RUN gem install bundler --no-document && bundle install

CMD ["bundle", "exec", "./cloud_status_alerter.rb"]
