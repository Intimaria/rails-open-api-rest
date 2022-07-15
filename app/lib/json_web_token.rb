require 'jwt'
require 'net/http'

class JsonWebToken
  class << self
    def verify(token)
      JWT.decode(token, nil,
                 false, # Verify the signature of this token
                 algorithm: algorithm,
                 iss: [ "#{domain}"],
                 verify_iss: true,
                 aud:"#{audience}",
                 verify_aud: true) do |header|
        key(header)
      end.first
    end
    
    def algorithm
      'RS256'
    end

    def key(header)
      jwks_hash[header['kid']]
    end

    def jwks_hash
      jwks_raw = Net::HTTP.get URI("#{domain}.well-known/jwks.json")
      puts(jwks_raw)
      jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
      jwks_keys.map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(Base64.decode64(k['x5c'].first)).public_key
        ]
      end.to_h
    end

    def audience
      "#{config[:audience]}"
    end
    def domain
      "#{config[:issuerUri]}"
    end

    def config 
      config = Auth0.config
    end
  end
end
