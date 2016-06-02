server 'localhost', user: 'fankami', roles: %w(web app db)

set :stage, 'local'
set :branch, 'master'
set :rails_env, :production

set :ssh_options, {
  keys: %w(~/.ssh/id_for_localhost),
  auth_methods: %w(publickey)
}