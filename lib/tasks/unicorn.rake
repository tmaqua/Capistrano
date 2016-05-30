require 'dotenv'
require 'aws-sdk'
Dotenv.load

namespace :aws do
  desc 'get ec2 list'
  task(:ec2) do
    ec2 = Aws::EC2::Client.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION']
    )
    ec2.start_instances(instance_ids: ['i-c2b29567'])
  end
end

