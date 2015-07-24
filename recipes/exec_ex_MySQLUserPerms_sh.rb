bash "copy hg.conf" do
  action :nothing
  code   <<-EOH
     cp /usr/local/src/kent/src/product/ex.hg.conf /usr/lib/cgi-bin/hg.conf
  EOH
end


mysqlsetupscriptpath="/usr/local/src/kent/src/product/ex.MySQLUserPerms.sh"
bash "execute ex.MySQLUserParams.sh" do
  action :nothing
  code   <<-EOH
     #{mysqlsetupscriptpath}
  EOH
  notifies :run, "bash[copy hg.conf]", :immediately
end


ruby_block "setup user and password for mysql" do
  block do
    rc = Chef::Util::FileEdit.new("#{mysqlsetupscriptpath}")
    # RewriteLog
    rc.search_file_replace(/^SQL_USER=\"\"/, "SQL_USER=\"-uroot\"")
    rc.search_file_replace(/^SQL_PASSWORD=\"\"/, "SQL_PASSWORD=\"ilovethispassword\"")
    rc.search_file_replace(/FILE\, \\/, "LOCK TABLES\, \\")
    rc.search_file_replace(/hg17/, "hg19")
    rc.write_file
  end
  action :run
end
