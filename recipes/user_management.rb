chef_gem 'mongo'

admin = node[:mongodb][:admin]

# If authentication is required,
# add the admin to the users array for adding/updating
users = [admin] if node['mongodb']['config']['auth'] == true

users.concat(node[:mongodb][:users])

# Add each user specified in attributes
users.each do |user|
  mongodb_user user['username'] do
    password user['password']
    roles user['roles']
    database user['database']
    action :add
  end
end
