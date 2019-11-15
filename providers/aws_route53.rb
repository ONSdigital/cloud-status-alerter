# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services Route 53.
class AwsRoute53 < AwsProvider
  def initialize
    super
    @name = 'AWS Route 53'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/route53.rss')
  end
end
