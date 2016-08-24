Pod::Spec.new do |s|
  s.name             = "Dust"
  s.summary          = "A short description of Dust."
  s.version          = "0.1.0"
  s.homepage         = "https://github.com/onmyway133/Dust"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = {
    :git => "https://github.com/onmyway133/Dust.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/onmyway133'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.2'

  s.requires_arc = true
  s.source_files = 'Sources/**/*'

  s.ios.frameworks = 'Foundation'
  s.osx.frameworks = 'Foundation'

  s.dependency 'Alamofire'

end
