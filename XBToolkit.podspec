Pod::Spec.new do |s|
  s.name         = "XBToolkit"
  s.version      = "0.0.16"
  s.summary      = "Xebia mapping and serializing tools for iOS & OSX."
  s.homepage     = "https://github.com/xebia-france/XBToolkit"
  s.author       = { 'Alexis Kinsella' => 'alexis.kinsella@gmail.com' }

  s.license      = 'Apache License, Version 2.0'
  s.source       = { :git => "https://github.com/xebia-france/XBToolkit.git", :commit => 'ec8fa3a04ad07aa1e2e1d569a0675327f37daae4' }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source_files = 'XBToolkit-common/**/*.{h,m}'
  s.ios.source_files = 'XBToolkit-ios/XBToolkit-ios/**/*.{h,m}'
  s.osx.source_files = 'XBToolkit-osx/XBToolkit-osx/**/*.{h,m}'

  s.requires_arc = true
  non_arc_files = 'Frameworks/GCJSONKit/*.{m}'
  s.ios.exclude_files = non_arc_files
  s.osx.exclude_files = non_arc_files

  s.subspec 'no-arc' do |sna|
    sna.requires_arc = false
    sna.ios.source_files = non_arc_files
    sna.osx.source_files = non_arc_files
  end

  s.requires_arc = true

  s.dependency 'Underscore.m',      '0.2.0'
  s.dependency 'DCKeyValueObjectMapping', '1.4'
  s.dependency 'AFNetworking',      '1.3.1'
  s.dependency 'GCJSONKit',         '~> 1.5'

end
