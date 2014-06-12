# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name        = "custom_rqrcode"
  s.version     = "0.2.0"
  s.licenses    = ['MIT']
  s.summary     = "Render QR codes with Rails 3"
  s.description = "Based on Rails, Render QR codes with the ability to customize your own QR codes"

  s.files       = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.date        = "2014-06-12"
  s.author      = "John Chang"
  s.email       = "johnchang2014@gmail.com"
  s.homepage    = "http://github.com/johnchang2014/custom_rqrcode"

  s.add_runtime_dependency 'rqrcode', '>= 0.4.2'
  s.add_runtime_dependency 'rqrcode-rails3', '~> 0.1.7'
  s.add_runtime_dependency 'mini_magick', '~> 3.7.0'
end
