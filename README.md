# GCP Status Alerter
This repository contains a Ruby script that consumes the [Google Cloud Status Dashboard](https://status.cloud.google.com/) JSON feed and posts corresponding alerts to a specified Slack channel as events occur. A [Google Cloud Firestore](https://firebase.google.com/docs/firestore/) database is used to track a little state to ensure duplicate updates aren't posted.

## Installation
* Ensure that [Ruby](https://www.ruby-lang.org/en/downloads/) is installed
* Install [Bundler](https://bundler.io/) using `gem install bundler`
* Install the RubyGems this script depends on using `bundle install`

## Running
### Environment Variables
The environment variables below are required:

```
FIRESTORE_CREDENTIALS # Path to the GCP service account JSON key
FIRESTORE_PROJECT     # Name of the GCP project containing the Firestore project
GCP_STATUS_ALERTS_SLACK_CHANNEL # Name of the Slack channel to post alerts to
SLACK_API_TOKEN
```

Run the script using `bundle exec ./gcp_status_alerter.rb`.

## Copyright
Copyright (C) 2019 Crown Copyright (Office for National Statistics)