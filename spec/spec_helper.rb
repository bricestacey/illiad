$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'illiad'
require 'rspec'

Rspec.configure do |config|
  config.mock_with :rspec

  # Do not include a trailing slash in the URL!
  config.add_setting :webcirc_url, :default => 'http://hostname/illiad/WebCirc'
  config.add_setting :webcirc_username, :default => 'username'
  config.add_setting :webcirc_password, :default => 'password'
end
