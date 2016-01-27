base = File.expand_path('..', __FILE__)

nodes_path                File.join(base, 'nodes')
role_path                 File.join(base, 'roles')
data_bag_path             File.join(base, 'data_bags')
encrypted_data_bag_secret File.join(base, 'data_bag_key')
environment_path          File.join(base, 'environments')
environment               "development"
ssl_verify_mode           :verify_peer

cookbook_path []
cookbook_path << File.join(base, 'cookbooks')
cookbook_path << File.join(base, 'site-cookbooks')
