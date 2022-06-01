require 'uri'
require 'net/http'
require 'json'

class GenerateToken
  class << self
    def test_token
      url = URI("#{config[:issuerUri]}oauth/token")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request.body = "{\"client_id\":\"#{config[:client_id]}\",\"client_secret\":\"#{config[:client_secret]}\",\"audience\":\"#{config[:audience]}\",\"grant_type\":\"client_credentials\"}"

      response = http.request(request)
      JSON.parse(response.read_body.as_json).symbolize_keys![:access_token]
    end

    def config 
      Auth0.config
    end 
  end
end