require 'rubygems'
require 'mocha'
require 'spec'

Spec::Runner.configure do |config|
  config.mock_with(:mocha)
end

require File.join(File.dirname(__FILE__), %w[.. lib http_headers])
