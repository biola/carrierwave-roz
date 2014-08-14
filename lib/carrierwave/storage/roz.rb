require 'open-uri'
require 'ostruct'

module CarrierWave
  module Storage
    class Roz < Abstract
      def store!(file)
        f = CarrierWave::Storage::Roz::File.new(uploader, uploader.store_path)
        f.store(file)
        f
      end

      def retrieve!(identifier)
        CarrierWave::Storage::Roz::File.new(uploader, uploader.store_path(identifier))
      end

      class File
        attr_reader :path
        attr_reader :uploader
        attr_reader :file

        def initialize(uploader, path)
          @uploader = uploader
          @path = path
        end

        def store(file)
          # RestClient wants a File not a CarrierWave::SanitizedFile because it calls
          # File#read([limit]) and SanitizedFile doesn't support a limit argument
          response = client.upload(file.to_file, path)

          unless (200..208).include? response.code
            # json = JSON.parse(response.to_str)
            # TODO: try to parse and raise JSON error message
            raise response.to_str
          end
        end

        def url(*args)
          URI.join(uploader.files_base_url, path).to_s
        end

        def filename
          ::File.basename(path)
        end

        def read
          file.content
        end

        def delete
          response = client.delete(path)

          unless (200..208).include? response.code
            # json = JSON.parse(response.to_str)
            # TODO: try to parse and raise JSON error message
            raise response.to_str
          end
        end

        def content_type
          file.content_type
        end

        def length
          file.length
        end

        alias :content_length :length
        alias :file_length :length
        alias :size :length

        protected

        def client
          CarrierwaveRoz::Client.new(uploader.api_base_url)
        end

        def file
          @file ||= open(url) do |f|
            OpenStruct.new content_type: f.content_type, content: f.read, length: f.length
          end
        end
      end
    end
  end
end
