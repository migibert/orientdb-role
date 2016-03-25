require 'spec_helper'

describe 'OrientDB' do
  describe service('orientdb') do
    it { should be_enabled }
  end

  describe port(2424) do
    it { should be_listening }
  end

  describe port(2480) do
    it { should be_listening }
  end
end
