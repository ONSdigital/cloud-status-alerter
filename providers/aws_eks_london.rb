# frozen_string_literal: true

require_relative '../aws_provider'

# Provider for Amazon Web Services EKS in London.
class AwsEksLondon < AwsProvider
  def initialize
    super
    @name = 'AWS EKS (London)'
  end

  def latest_update
    super('https://status.aws.amazon.com/rss/eks-eu-west-2.rss')
  end
end
