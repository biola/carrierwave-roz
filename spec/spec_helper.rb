$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
$:.unshift File.expand_path(File.dirname(__FILE__))

ENV['RACK_ENV'] = 'test'

require 'bundler/setup'

require 'combustion'
require 'capybara/rspec'
Combustion.initialize! :active_record, :action_controller, :action_view

require 'rspec/rails'
require 'capybara/rails'
require 'webmock/rspec'

require 'active_record'
require 'carrierwave'


RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.before do
    stub_request(:post, 'http://example.com/v2/files/upload')
    stub_request(:delete, %r{\Ahttp://example.com/v2/files/delete.*})
  end
end
