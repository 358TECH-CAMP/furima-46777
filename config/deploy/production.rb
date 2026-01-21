server '13.230.163.131', user: 'ec2-user', roles: %w{app db web}

set :ssh_options, {
  keys: %w(~/.ssh/furima-key.pem), # 鍵の名前を furima-key.pem に修正しました
  forward_agent: true,
  auth_methods: %w(publickey)
}