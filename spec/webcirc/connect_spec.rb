require 'spec_helper'

describe Illiad::WebCirc::Base, "#connected?" do
  before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
    @webcirc = Illiad::WebCirc::Base.new(@url, @username, @password)      
  end

  context "when not signed in" do
    it "should not be connected" do
      @webcirc.connected?.should == false
    end
  end

  context "when signed in" do
    before(:each) do
      @webcirc.establish_connection
    end

    it "should be connected" do
      @webcirc.connected?.should == true
    end

    it "last page in history should be Default.aspx" do
      @webcirc.connected?
      @webcirc.conn.history.last.uri.request_uri.include?(Illiad::WebCirc::Base::URL_PATH_DEFAULT).should == true
    end
  end
end

describe Illiad::WebCirc::Base, "#establish_connection" do 
  before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
  end

  it "should return true on success" do
    @webcirc = Illiad::WebCirc::Base.new(@url, @username, @password)
    @webcirc.establish_connection.should == true
  end

  it "should return false when given a bad url" do
    @webcirc = Illiad::WebCirc::Base.new(@url, '', @password)
    @webcirc.establish_connection.should == false
  end

  it "should return false when given a bad username" do
    @webcirc = Illiad::WebCirc::Base.new(@url, @username, '')
    @webcirc.establish_connection.should == false
  end

  it "should return false when given a bad password" do
    @webcirc = Illiad::WebCirc::Base.new('', @username, @password)
    @webcirc.establish_connection.should == false
  end
end

describe Illiad::WebCirc::Base, "#disconnect" do
  before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
    @webcirc = Illiad::WebCirc::Base.new(@url, @username, @password)
  end

  context "when not signed in" do
    it "should return true" do
      @webcirc.disconnect.should == true
    end
  end

  context "when signed in" do
    it "should return true" do
      if @webcirc.establish_connection
        @webcirc.disconnect.should == true
      end
    end
  end
end

=begin
describe Illiad::WebCirc::Base, "#charge!" do
  before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
    @webcirc = Illiad::WebCirc::Base.new(@url, @username, @password)
    @webcirc.establish_connection
  end

  it "should return true on success" do
    @webcirc.charge!(91818).should == true
  end
end

describe Illiad::WebCirc::Base, "#discharge!" do
   before(:all) do
    @url = Rspec.configuration.webcirc_url
    @username = Rspec.configuration.webcirc_username
    @password = Rspec.configuration.webcirc_password
    @webcirc = Illiad::WebCirc::Base.new(@url, @username, @password)
    @webcirc.establish_connection
  end

  it "should return true on success" do
    @webcirc.discharge!(91818).should == true
  end
end
=end
