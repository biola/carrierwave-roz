class PhotoUploader < CarrierWave::Uploader::Base
  storage :roz

  api_base_url    "http://example.com"
  files_base_url  "http://example.com"
  access_id       "dummyaccessid"
  secret_key      "dummysecretkey"

  version :small
  version :medium
  version :large

  def store_dir
    'custom/store/dir'
  end
end
