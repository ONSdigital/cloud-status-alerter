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
FIRESTORE_PROJECT           # Name of the GCP project containing the Firestore project
SLACK_BOT_TOKEN             # Used for accessing the Slack API
STATUS_ALERTS_SLACK_CHANNEL # Name of the Slack channel to post alerts to
```

The environment variable below is optional:

```
FIRESTORE_CREDENTIALS       # Path to the GCP service account JSON key (used when running locally)
```

Run the script using `bundle exec ./cloud_status_alerter.rb`.

## Providers
Updates from a status feed source are implemented by providers, which are simply classes within the `providers` directory that conform to these rules:

* Provider classes must inherit from the `Provider` base class
* Provider class names must have an initial capital and then be all lower-case e.g. `Github`
* The provider class's `initialize` method must set the `@icon` and `@name` for use within the Slack message (the icon should be the name of a Slack emoji minus the surrounding colons)
* The provider class must implement a `latest_update` method that returns a populated `StatusFeedUpdate` struct. This struct contains the following fields:

| Field     | Purpose                                                                                |
| ----------| -------------------------------------------------------------------------------------- |
| id        | Unique ID for the update. Not displayed, used as a document key in Firestore           |
| timestamp | Timestamp of the update                                                                |
| metadata  | Optional additional information about the update e.g. the name of the service affected |
| text      | Status update text                                                                     |
| uri       | URI for viewing this individual status update online                                   |

## Copyright
Copyright (C) 2019&ndash;2020 Crown Copyright (Office for National Statistics)