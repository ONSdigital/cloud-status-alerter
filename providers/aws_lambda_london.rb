# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Lambda in London.
class AwsLambdaLondon < AwsProvider
  def initialize
    super
    @name = 'AWS Lambda (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/lambda-eu-west-2.rss')
  end
end
