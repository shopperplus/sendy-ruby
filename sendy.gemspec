Gem::Specification.new do |s|
  s.name        = 'sendy'
  s.version     = '0.0.1'
  s.date        = '2017-06-06'
  s.summary     = "Sendy!"
  s.description = "A simple Sendy API"
  s.authors     = ["benko"]
  s.email       = 'benko.b@shopperplus.com'
  s.files       = ["lib/sendy.rb", "lib/sendy/base.rb", "lib/sendy/client.rb", "lib/sendy/version.rb"]
  s.require_paths = ["lib"]
  s.add_dependency("faraday", "~> 0.9")
end