service "haproxy" do
  action :stop
end

yum_package "haproxy" do
  action :remove
end

directory "/etc/haproxy" do
  recursive true
  action :delete
end
