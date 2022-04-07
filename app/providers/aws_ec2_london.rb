# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services EC2 in London.
class AwsEc2London < AwsProvider
  def initialize
    super
    @name = 'AWS EC2 (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/ec2-eu-west-2.rss')
  end
end
