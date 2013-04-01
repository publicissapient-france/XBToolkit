Pod::Spec.new do |s|
  s.name         = "XBToolkit"
  s.version      = "0.0.4"
  s.summary      = "Xebia Toolkit for iOS & OSX."
  s.homepage     = "https://github.com/xebia-france/XBToolkit"
  s.author       = { 'Alexis Kinsella' => 'alexis.kinsella@gmail.com' }

  s.license      = 'Apache License, Version 2.0'
  s.source       = { :git => "https://github.com/xebia-france/XBToolkit.git", :tag => "0.0.4" }

#  s.platform = :osx, "10.7"
#  s.platform = :ios, "5.0"
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source_files = 'XBToolkit-common/**/*.{h,m}'
  s.ios.source_files = 'XBToolkit-ios/XBToolkit-ios/**/*.{h,m}'
  s.ios.prefix_header_file = 'XBToolkit-ios/XBToolkit-ios/XBToolkit-ios-Prefix.pch'
  s.osx.source_files = 'XBToolkit-osx/XBToolkit-osx/**/*.{h,m}'
  s.osx.prefix_header_file = 'XBToolkit-osx/XBToolkit-osx/XBToolkit-osx-Prefix.pch'

  s.requires_arc = true

  s.dependency 'JSONKit',						'1.5pre'
  s.dependency 'Underscore.m',					'0.2.0'
  s.dependency 'AFNetworking',					'1.1'
  s.dependency 'AFHTTPRequestOperationLogger',	'0.10.0'
  s.dependency 'DCKeyValueObjectMapping',		'1.3'
  s.dependency 'CocoaLumberjack',				'1.6'

end
