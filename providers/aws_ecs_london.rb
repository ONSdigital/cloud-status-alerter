# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services ECS in London.
class AwsEcsLondon < AwsProvider
  def initialize
    super
    @name = 'AWS ECS (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/ecs-eu-west-2.rss')
  end
end
