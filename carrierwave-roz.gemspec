lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'carrierwave_roz/version'

spec = Gem::Specification.new do |s|
  s.name = 'carrierwave-roz'
  s.version = CarrierwaveRoz::VERSION
  s.summary = 'CarrierWave storage plugin for Roz'
  s.description = 'CarrierWave plugin for storing files in the Roz files API'
  s.files = Dir['README.*', 'MIT-LICENSE', 'lib/**/*.rb']
  s.require_path = 'lib'
  s.author = 'Adam Crownoble'
  s.email = 'adam@obledesign.com'
  s.homepage = 'https://github.com/biola/carrierwave-roz'
  s.license = 'MIT'
  s.add_dependency('api-auth', '~> 1.2')
  s.add_dependency('carrierwave', '~> 0.10.0')
  s.add_dependency('multipart-post', '~> 2.0')
  s.add_development_dependency('combustion', '~> 0.5')
  s.add_development_dependency('capybara', '~> 2.4')
  s.add_development_dependency('rspec-rails', '~> 3.1')
  s.add_development_dependency('launchy', '~> 2.4')
  s.add_development_dependency('activerecord', '~> 4.1')
  s.add_development_dependency('actionpack', '~> 4.1')
  s.add_development_dependency('sqlite3', '~> 1.3')
  s.add_development_dependency('webmock', '~> 1.20')
end
