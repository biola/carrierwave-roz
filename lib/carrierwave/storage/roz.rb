require 'open-uri'
require 'ostruct'

module CarrierWave
  module Storage
    class Roz < Abstract
      def identifier
        ::File.join(*[uploader.access_id, uploader.store_dir, uploader.filename].map(&:to_s))
      end

      def store!(file)
        f = CarrierWave::Storage::Roz::File.new(uploader, identifier)
        f.store(file)
        f
      end

      def retrieve!(identifier)
        CarrierWave::Storage::Roz::File.new(uploader, identifier)
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
          response = client.upload(file, path)

          unless (200..208).include? response.code.to_i
            # json = JSON.parse(response.to_str)
            # TODO: try to parse and raise JSON error message
            raise response.to_s
          end
        end

        def url(*args)
          if path == ::File.basename(path)
            # Backwards compatibility for when we were storing only the filename
            URI.join(uploader.files_base_url, "#{uploader.access_id.to_s}/", "#{uploader.store_dir}/", path).to_s
          else
            URI.join(uploader.files_base_url, path).to_s
          end
        end

        def filename
          ::File.basename(path)
        end

        def read
          file.content
        end

        def delete
          response = client.delete(path)

          unless (200..208).include? response.code.to_i
            # json = JSON.parse(response.to_str)
            # TODO: try to parse and raise JSON error message
            raise response.to_s
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
          CarrierwaveRoz::Client.new(uploader.api_base_url, uploader.access_id, uploader.secret_key)
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
