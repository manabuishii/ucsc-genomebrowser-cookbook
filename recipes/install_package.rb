#
extract_path = "/usr/src/"
%w{
libmysqlclient-dev
}.each do |p|
    package p do
    action :install
  end
end
