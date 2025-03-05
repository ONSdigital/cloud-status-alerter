# FROM europe-west2-docker.pkg.dev/ons-ci/ons-ci/cloud-status-alerter-parent-image:latest
FROM europe-west2-docker.pkg.dev/ons-ci/ons-ci/cloud-status-alerter-parent-image:latest

WORKDIR /usr/src/app
COPY . ./

CMD ["bundle", "exec", "./cloud_status_alerter.rb"]