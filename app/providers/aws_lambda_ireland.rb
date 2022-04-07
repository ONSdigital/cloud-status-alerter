# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Lambda in Ireland.
class AwsLambdaIreland < AwsProvider
  def initialize
    super
    @name = 'AWS Lambda (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/lambda-eu-west-1.rss')
  end
end
