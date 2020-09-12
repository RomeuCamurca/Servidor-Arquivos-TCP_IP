#
# Cookbook Name:: cassandra-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


yum_repository "datastax" do
  description "DataStax Repo for Apache Cassandra"
  baseurl "#{node['cassandra']['baseurl']}"
  enabled true
  gpgcheck node['cassandra']['gpgcheck']
  gpgkey "#{node['cassandra']['gpgkey']}"
  action :create
end

pkg_list = %w{java-1.8.0-openjdk-headless dsc22}

pkg_list.each do |pkg|
  yum_package pkg do
    action :install
  end
end

bash 'update init.d script, create /var/run/cassandra on startup' do
  user 'root'
  code <<-EOH
    cmd_lines="\        mkdir -p /var/run/cassandra\n\        chown cassandra:cassandra /var/run/cassandra"
    sed -i -e "/Starting Cassandra/a $cmd_lines" /etc/init.d/cassandra
    EOH
  not_if { "grep 'mkdir -p /var/run/cassandra /etc/init.d/cassandra" }
end

template '/etc/cassandra/conf/cassandra.yaml' do
  source 'cassandra.yaml.erb'
  action :create
  notifies :restart, 'service[restart-cassandra]', :delayed
end

service "restart-cassandra" do
  service_name "cassandra"
  supports :status => true, :start => true, :stop => true, :restart => true
  action :nothing
  only_if { File.exists?('/var/run/cassandra/cassandra.pid') }
end

service "cassandra" do
  service_name "cassandra"
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :enable, :start ]
  not_if { File.exists?('/var/run/cassandra/cassandra.pid') }
end
