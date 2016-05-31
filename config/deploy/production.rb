# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}

require 'dotenv'
require 'aws-sdk'
Dotenv.load

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

ec2 = Aws::EC2::Client.new
response = ec2.describe_instances instance_ids: target_instance_ids
ip_addresses = response.reservations.map {|r| r.instances.map {|i| i.public_ip_address } }.flatten

ip_addresses.each do |ip|
  server ip.to_s, user: 'fankami', roles: %w{app db web}
end
# server '52.68.208.114', user: 'fankami', roles: %w{app db web}
set :ssh_options, {
    keys: %w(~/.ssh/aws.fankami/aws_fankami),
    forward_agent: true,
    auth_methods: %w(publickey)
  }

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
