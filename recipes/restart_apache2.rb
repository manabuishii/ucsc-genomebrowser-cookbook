apacheservice="httpd"
apacheetcpath="httpd"
case node[:platform]
when "ubuntu"
  apacheservice="service apache2"
  apacheetcpath="apache2"
end


bash "restartapache" do
  action :run
  code   <<-EOH
     #{apacheservice} restart
  EOH
end
