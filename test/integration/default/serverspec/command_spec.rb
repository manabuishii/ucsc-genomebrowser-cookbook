require 'spec_helper'

RSpec.configure do |c|
  c.output_stream = File.open('/tmp/result/serverspec-result.xml', 'w')
  c.formatter = 'RspecJunitFormatter'
end


describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe command('ls -al /') do
  its(:stdout) { should match /bin/ }
end

describe command('which ls') do
  its(:exit_status) { should eq 0 }
end

%w{
  git
  unzip
  make
}.each { |command|
describe command('which '+command) do
  its(:exit_status) { should eq 0 }
end
}
