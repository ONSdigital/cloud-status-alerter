# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services RDS in Ireland.
class AwsRdsIreland < AwsProvider
  def initialize
    super
    @name = 'AWS RDS (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/rds-eu-west-1.rss')
  end
end
