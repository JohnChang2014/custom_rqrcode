# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name        = "custom_rqrcode"
  s.summary     = "Render QR codes with Rails 3"
  s.description = "Based on Rails, Render QR codes with the ability to customize your own QR codes"

  s.files       = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.date        = "2013-06-30"
  s.author      = "Johnson Chang"
  s.email       = "johnsonchang2012@gmail.com"
  s.homepage    = "http://github.com/johnsonchang2012/custom_rqrcode"
  s.version     = "0.0.1"

  s.add_dependency 'rqrcode', '>= 0.4.2'
end
