# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services DynamoDB in Ireland.
class AwsDynamoDbIreland < AwsProvider
  def initialize
    super
    @name = 'AWS DynamoDB (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/dynamodb-eu-west-1.rss')
  end
end
