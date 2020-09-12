#
# Cookbook Name:: haproxy-cookbook
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
yum_package "haproxy" do
  action :upgrade
  flush_cache [:before]
end

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  notifies :restart, 'service[haproxy]', :immediately
end

service "haproxy" do
  provider Chef::Provider::Service::Redhat
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
