#
remote_file "#{Chef::Config['file_cache_path']}/jksrc.zip" do
  source "http://hgdownload.cse.ucsc.edu/admin/jksrc.zip"
  mode   0644
  retries 3
  checksum "da17671b1e91852ef3df0943a49c5ca2a37f7d1dc1a0e0df4ca94113d4b257a6"
  not_if "test -f #{Chef::Config['file_cache_path']}/jksrc.zip"
end
#
bash "extract_source" do
  code <<-EOH
    unzip #{Chef::Config['file_cache_path']}/jksrc.zip -d #{extract_path}
  EOH
  not_if { ::File.exist?(extract_path+"/kent") }
end
