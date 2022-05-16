class Auth0
  def config 
    config = YAML.load(ERB.new(File.read("#{Rails.root}/config/auth0.yml")).result)
  end
end