# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services EC2 in Ireland.
class AwsEc2Ireland < AwsProvider
  def initialize
    super
    @name = 'AWS EC2 (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/ec2-eu-west-1.rss')
  end
end
