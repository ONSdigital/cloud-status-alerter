# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services DynamoDB in London.
class AwsDynamoDbLondon < AwsProvider
  def initialize
    super
    @name = 'AWS DynamoDB (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/dynamodb-eu-west-2.rss')
  end
end
