#
extract_path = "/usr/src/"
%w{
unzip
git
}.each do |p|
    package p do
    action :install
  end
end
