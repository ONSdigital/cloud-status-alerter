FROM europe-west2-docker.pkg.dev/ons-ci/ons-ci/cloud-status-alerter-parent-image:latest

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
COPY providers/ ./providers/
COPY aws_provider.rb cloud_status_alerter.rb provider.rb ./

CMD ["bundle", "exec", "./cloud_status_alerter.rb"]