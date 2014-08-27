require 'net/http/post/multipart'
require 'api_auth'

module CarrierwaveRoz
  class Client
    VERSION = 'v1'

    attr_reader :base_url
    attr_reader :access_id
    attr_reader :secret_key

    def initialize(base_url, access_id, secret_key)
      @base_url = base_url
      @access_id = access_id
      @secret_key = secret_key
    end

    def upload(file, path)
      uri = url_for(:upload)
      upload = UploadIO.new(file.to_file, file.content_type, file.original_filename)
      request = Net::HTTP::Post::Multipart.new uri.path, 'file' => upload, 'path' => path

      # Set Content-MD5 header.
      # This works around an incompatibility between api_auth and multipart-post.
      # It should no longer be required with api-auth > 1.2.3
      body = request.body_stream.read
      request.body_stream.rewind
      request['Content-MD5'] = Digest::MD5.base64digest(body)

      send_request request, uri
    end

    def delete(path)
      uri = url_for(:delete, path: path)

      send_request Net::HTTP::Delete.new(uri.request_uri), uri
    end

    private

    def url_for(action, params = {})
      URI.join(base_url, "#{VERSION}/files/#{action}").tap do |uri|
        uri.query = URI.encode_www_form(params).presence
      end
    end

    def send_request(request, uri)
      ApiAuth.sign! request, access_id, secret_key

      Net::HTTP.start(uri.host, uri.port) do |http|
        http.use_ssl = true if uri.scheme == 'https'
        http.request(request)
      end
    end
  end
end
