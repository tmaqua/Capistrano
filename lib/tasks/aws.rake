require 'aws-sdk'

namespace :aws do
  desc 'ELB Instance List'
  task :list => :environment do
    elb = Aws::ElasticLoadBalancing::Client.new(
      region: ENV["AWS_REGION"],
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )

    instance_states = 
      elb.describe_instance_health(load_balancer_name: ENV["AWS_ELB_NAME"]).instance_states

    target_instance_ids = []
    instance_states.each do |instance_state|
      if instance_state.state == 'InService'
        target_instance_ids.push(instance_state.instance_id) 
      end
    end

    puts target_instance_ids

    ec2 = Aws::EC2::Client.new
    response = ec2.describe_instances instance_ids: target_instance_ids
    ip_addresses = response.reservations.map {|r| r.instances.map {|i| i.public_ip_address } }.flatten

    puts ip_addresses

  end

end

