CarrierWave Roz
===============

carrierwave-roz is a [carrierwave](https://github.com/carrierwaveuploader/carrierwave) storage plugin that for the [roz](https://github.com/biola/roz) file storage API.

Installation
------------

Add the following to your `Gemfile`

    gem carrierwave-roz

Run `bundle install`

Usage
-----

Add the following to your uploader class

```ruby
class ExampleUploader < CarrierWave::Uploader::Base
  storage :roz
 
  api_base_url    "https://api.example.com/assets"
  files_base_url  "https://assets.example.com"
  access_id       "*************"
  secret_key      "*************"
  # ...
```

*See [Roz documentation](https://github.com/biola/roz#configuration) for creating cilent `access_id` and `secret_key`*
