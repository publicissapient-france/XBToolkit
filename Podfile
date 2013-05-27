platform :ios,						'5.0'
pod 'JSONKit',      		 		'1.5pre'
pod 'Underscore.m',					'0.2.0'
pod 'AFNetworking',					'1.1'
pod 'AFHTTPRequestOperationLogger',	'0.10.0'
pod 'DCKeyValueObjectMapping', 		'1.3'
pod 'OCMock',						'2.0.1'
#pod 'CocoaLumberjack',				'1.6'
#pod 'OCMockito',					'0.23'

target 'XBToolkit-osxTests', :exclusive => true do
  pod 'GHUnitIOS',					'0.5.6'
end

target 'XBToolkit-osx', :exclusive => false do
  platform :osx,					'10.7'
  target 'XBToolkit-osxTests', :exclusive => true do
	pod 'GHUnitOSX',				'0.5.6'
  end
end
