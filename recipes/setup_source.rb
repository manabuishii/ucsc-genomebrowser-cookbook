#
jksrcurl=node[:ucscGenomeBrowser][:jksrc][:url]
jksrcchecksum=node[:ucscGenomeBrowser][:jksrc][:checksum]

remote_file "#{Chef::Config['file_cache_path']}/jksrc.zip" do
  source "#{jksrcurl}"
  mode   0644
  retries 3
  checksum "#{jksrcchecksum}"
  not_if "test -f #{Chef::Config['file_cache_path']}/jksrc.zip"
end
#
extract_path = "/usr/local/src"

bash "extract_source" do
  code <<-EOH
    unzip #{Chef::Config['file_cache_path']}/jksrc.zip -d #{extract_path}
  EOH
  not_if { ::File.exist?(extract_path+"/kent") }
end
#
bash "setup_printEnv" do
  printEnvFile = "/usr/lib/cgi-bin/printEnv.pl"
  code <<-EOH
    sed -e 's/\\/usr\\/local\\/bin\\/perl/\\/usr\\/bin\\/env perl/' /usr/local/src/kent/src/product/scripts/printEnv.pl > #{printEnvFile}
    chmod 755 #{printEnvFile}
  EOH
  not_if { ::File.exist?(printEnvFile) }
end
