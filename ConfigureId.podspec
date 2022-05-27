Pod::Spec.new do |s|
  s.name             = 'ConfigureId'
  s.version          = '0.0.4'
  s.summary          = 'This API exposes the endpoints necessary for interacting with Configure ID'
  s.homepage         = 'https://github.com/FranDepascuali/ConfigureID-iOS-SDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Francisco Depascuali' => 'depa.developer@gmail.com' }
  s.source           = { :git => 'https://github.com/FranDepascuali/ConfigureID-iOS-SDK.git', :tag => "v" + s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.5'
  s.source_files = 'Sources/ConfigureId/**/*'
end