# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services RDS in London.
class AwsRdsLondon < AwsProvider
  def initialize
    super
    @name = 'AWS RDS (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/rds-eu-west-2.rss')
  end
end
