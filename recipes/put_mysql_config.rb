mysqlservice="mysql"
mysqletcpath="httpd"
case node[:platform]
when "ubuntu"
  mysqlservice="service mysql"
  mysqletcpath="mysql"
end




bash "restartmysql" do
  action :nothing
  code   <<-EOH
     #{mysqlservice} restart
  EOH
end

template "/etc/mysql/conf.d/deafult.cnf" do
  source 'mysql_config.erb'
  owner 'mysql'
  group 'mysql'
  mode '0644'
  #action :nothing
  notifies :run, "bash[restartmysql]", :immediately
end

# directory "/etc/mysql/conf.d" do
#   recursive true
#   owner 'mysql'
#   group 'mysql'
#   mode '0750'
#   action :create
#   notifies :run, "template[/etc/mysql/conf.d/deafult.cnf]", :immediately
#
# end
