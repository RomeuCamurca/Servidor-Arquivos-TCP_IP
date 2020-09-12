service "cassandra" do
  service_name "cassandra"
  action :stop
end

pkg_list = %w{dsc22 cassandra22}

pkg_list.each do |pkg|
  yum_package pkg do
    action :remove
    ignore_failure true
  end
end

directory_list = %w{/etc/cassandra /var/lib/cassandra /var/log/cassandra}

directory_list.each do |dir|
  directory dir do
    recursive true
    action :delete
    ignore_failure true
  end
end
