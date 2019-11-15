# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services EKS in Ireland.
class AwsEksIreland < AwsProvider
  def initialize
    super
    @name = 'AWS EKS (Ireland)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/eks-eu-west-1.rss')
  end
end
