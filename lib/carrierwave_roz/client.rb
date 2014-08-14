require 'rest_client'

module CarrierwaveRoz
  class Client
    VERSION = 'v1'

    attr_reader :base_url

    def initialize(base_url)
      @base_url = base_url
    end

    def upload(file, path)
      RestClient.post url_for('upload'), file: file, path: path
    end

    def delete(path)
      RestClient.delete url_for('delete'), params: {path: path}
    end

    private

    def url_for(action)
      URI.join(base_url, "#{VERSION}/files/#{action}").to_s
    end
  end
end
