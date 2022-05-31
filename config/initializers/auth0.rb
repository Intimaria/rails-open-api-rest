class Auth0
  def self.config 
    config = YAML.load(ERB.new(File.read("#{Rails.root}/config/auth0.yml")).result)
    config.symbolize_keys!
  end
end