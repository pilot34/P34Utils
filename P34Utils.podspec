Pod::Spec.new do |s|
  s.name         = 'P34Utils'
  s.version      = '0.0.1'
  s.summary      = 'Some useful utils classes.'
  s.homepage     = 'https://github.com/pilot34/Utils'
  s.license      = 'MIT'
  s.author       = { 'pilot34' => 'gleb34@gmail.com' }
  s.source       = { :git => 'https://github.com/pilot34/Utils.git', :branch => 'pods' }
  s.platform     = :ios, '5.0'
  s.source_files = './*.{h,m}','./Libs/**/*.{h,m}'
  s.resources = ''
  s.requires_arc = true
  s.library   = 'Libs/GoogleAnalytics/libGoogleAnalytics.a'
  s.dependency 'Nimbus'
  s.dependency 'UIDeviceAddition'
  s.dependency 'Reachability'
  s.dependency 'ASIHTTPRequest'
  s.dependency 'GoogleAnalytics-iOS-SDK'
  s.prefix_header_contents = '#import "P34Utils.h"'
end