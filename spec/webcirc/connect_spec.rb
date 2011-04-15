require 'spec_helper'

describe Illiad::Webcirc, "#connect" do 
  before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
  end

  it "should return true on success" do
    @webcirc = Illiad::Webcirc.new(@url, @username, @password)
    @webcirc.connect.should == true
  end
end

describe Illiad::Webcirc, "#charge!" do
  before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
    @webcirc = Illiad::Webcirc.new(@url, @username, @password)
    @webcirc.connect
  end

  it "should return true on success" do
    @webcirc.charge!(91818).should == true
  end
end

describe Illiad::Webcirc, "#discharge!" do
   before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
    @webcirc = Illiad::Webcirc.new(@url, @username, @password)
    @webcirc.connect
  end

  it "should return true on success" do
    @webcirc.discharge!(91818).should == true
  end
end
