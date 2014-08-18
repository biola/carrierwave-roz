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
  s.add_dependency('carrierwave', '~> 0.10')
  s.add_dependency('multipart-post', '~> 2.0')
end
