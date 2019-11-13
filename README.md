# Cloud Status Alerter
This repository contains a Ruby script that consumes the various service/vender status feeds and posts corresponding alerts to a specified Slack channel as events occur. A [Google Cloud Firestore](https://firebase.google.com/docs/firestore/) database is used to track a little state to ensure duplicate updates aren't posted.

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
SLACK_WEBHOOK
STATUS_ALERTS_SLACK_CHANNEL # Name of the Slack channel to post alerts to
```

Run the script using `bundle exec ./cloud_status_alerter.rb`.

## Providers
* Add new providers to the `providers` directory
* Provider classes must inherit from the `Provider` base class
* The `initialize` method needs to set the `@icon` and `@name` for use within the Slack message
* Implement a `latest_update` method that returns a populated `StatusFeedUpdate` struct declared within the `Provider` class. Note that the `metadata` field is optional

## Copyright
Copyright (C) 2019 Crown Copyright (Office for National Statistics)