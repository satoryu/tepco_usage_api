require File.expand_path(File.join(
          File.dirname(__FILE__), '..', 'lib',
          'tepco_usage_api'))

RSpec.configure do |c|
  c.mock_with :rspec
end
