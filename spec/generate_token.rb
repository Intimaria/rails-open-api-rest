require 'uri'
require 'net/http'



class GenerateToken
  class << self
    def test_token
      url = URI(config[:audience])

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request.body = "{\"client_id\":\"#{config[:client_id]}\",\"client_secret\":\"#{config[:client_secret]}\",\"audience\":\"#{config[:audience]}\",\"grant_type\":\"client_credentials\"}"

      response = http.request(request)
      response.read_body 
    end

    def config 
      Auth0.config
    end 
  end
end