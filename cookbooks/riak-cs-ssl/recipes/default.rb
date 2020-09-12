key   = "/etc/riak-cs/riak-cs-key.pem"
cert  = "/etc/riak-cs/riak-cs-cert.pem"

directory "/etc/riak-cs" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

[ "key", "cert" ].each do |file_name|
  file "/etc/riak-cs/#{file_name}.pem" do
    action :delete
  end
end

execute "riak-cs-keypair" do
  command "openssl genrsa -out #{key} 2048"
  creates key
  notifies :restart, "service[riak-cs]"
end

execute "riak-cs-cert" do
  command <<-CMD
    openssl req \
      -x509 -nodes -days 3650 \
      -subj '/C=US/ST=Massachusetts/L=Cambridge/CN=*.#{node["fqdn"].split(".").last(2).join(".")}' \
      -new -key #{key} -out #{cert}
  CMD
  creates cert
  notifies :restart, "service[riak-cs]"
end

node.override['riak_cs']['config']['riak_cs']['stanchion_ssl'] = true
node.override['riak_cs']['config']['riak_cs']['ssl'] = [["certfile", cert.to_erl_string].to_erl_tuple, ["keyfile", key.to_erl_string].to_erl_tuple]
node.override['stanchion']['config']['stanchion']['ssl'] = [["certfile", cert.to_erl_string].to_erl_tuple, ["keyfile", key.to_erl_string].to_erl_tuple]

include_recipe "riak-cs"
include_recipe "riak-cs::stanchion"
