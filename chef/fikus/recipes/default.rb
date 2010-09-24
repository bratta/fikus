#
# Cookbook Name:: fikus
# Recipe:: default
#

# Copy customized config files into place
# for your fikus website

if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  node[:applications].each do |app_name,data|

    mongodb_master = 'localhost'
    node[:utility_instances].each do |util_instance|
      if util_instance[:name].match(/mongodb_master/)
        mongodb_master = util_instance[:hostname]
      end
    end

    user = node[:users].first

    remote_file "/data/#{app_name}/shared/config/fikus.yml" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
      source "fikus.yml"
      backup false
      action :create
    end

    template "/data/#{app_name}/shared/config/database.rb" do
      source "database.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
      variables({
        :database => "#{app_name}_#{node[:environment][:framework_env]}",
        :hostname => mongodb_master,
        :username => user[:username],
        :password => user[:password]
      })
    end
  end
end