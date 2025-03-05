# FROM europe-west2-docker.pkg.dev/ons-ci/ons-ci/cloud-status-alerter-parent-image:latest
FROM eu.gcr.io/ons-catd-apps/cloud-status-alerter-parent-image

WORKDIR /usr/src/app
COPY . ./

CMD ["bundle", "exec", "./cloud_status_alerter.rb"]