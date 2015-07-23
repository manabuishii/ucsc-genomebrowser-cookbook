require 'spec_helper'

describe "zabbix web" do
  getcommand = "curl http://localhost/cgi-bin/printEnv.pl"
  if ['debian', 'ubuntu'].include?(os[:family])
    getcommand = "wget http://localhost/cgi-bin/printEnv.pl -O -"
  end
  describe command(getcommand) do
    its(:stdout) { should match /testing CGI/ }
    its(:exit_status) { should eq 0 }
  end
end
