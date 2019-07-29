# GCP Status Alerter
This repository contains a Ruby script that consumes the [Google Cloud Status Dashboard](https://status.cloud.google.com/) JSON feed and posts corresponding alerts to a specified Slack channel as events occur.

## Installation
* Ensure that [Ruby](https://www.ruby-lang.org/en/downloads/) is installed
* Install [Bundler](https://bundler.io/) using `gem install bundler`
* Install the RubyGems this script depends on using `bundle install`

## Running
### Environment Variables
The environment variables below are required:

```
GCP_STATUS_ALERTS_SLACK_CHANNEL
SLACK_API_TOKEN
```

Run the script using `bundle exec ./gcp_status_alerter.rb`.

## Copyright
Copyright (C) 2019 Crown Copyright (Office for National Statistics)