require 'carrierwave'

module CarrierwaveRoz
  autoload :Client, 'carrierwave_roz/client'
end

CarrierWave::Storage.autoload :Roz, 'carrierwave/storage/roz'

class CarrierWave::Uploader::Base
  add_config :api_base_url
  add_config :files_base_url
  add_config :access_id
  add_config :secret_key

  configure do |config|
    config.storage_engines[:roz] = "CarrierWave::Storage::Roz"
    config.api_base_url = 'http://roz.dev'
    config.files_base_url = 'http://assets.dev'
  end
end
