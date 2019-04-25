Pod::Spec.new do |s|
  s.name             = 'GTPlayer'
  s.version          = '0.1.4'
  s.summary          = 'Small easy to use player layer. Nice'
  s.swift_version = '4.2'
  s.dependency 'AlamofireImage'
  s.description      = <<-DESC
This is a ready made player view with necessary methods.
                       DESC
 
  s.homepage         = 'https://github.com/gokhanmandaci/GTPlayer'
  s.license          = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author           = { 'gokhanmandaci' => 'gokhanmandaci@gmail.com' }
  s.source           = { :git => 'https://github.com/gokhanmandaci/GTPlayer.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'GTPlayer/*'
 
end