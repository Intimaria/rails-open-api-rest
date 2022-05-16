require 'uri'
require 'net/http'



class GenerateToken
  class << self
    def test_token
      url = URI("https://dev-lmzlz5ay.us.auth0.com/oauth/token")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request.body = "{\"client_id\":\"rywe364iEJrFe0KPMOgUoZ77yBL45IKO\",\"client_secret\":\"6TtoaRlA80ZAjqKTIEoI9ek0UiAV80OjSmqhOM_6n4QsS-Vi0Wwen8qLj3c4TSyu\",\"audience\":\"https://open-api-swagger.herokuapp.com/api/v1/todos\",\"grant_type\":\"client_credentials\"}"

      response = http.request(request)
      response.read_body 
    end
  end
end