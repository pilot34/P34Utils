Pod::Spec.new do |s|
  s.name         = 'P34Utils'
  s.version      = '0.0.1'
  s.summary      = 'Some useful utils classes.'
  s.homepage     = 'https://github.com/pilot34/P34Utils'
  s.license      = 'MIT'
  s.author       = { 'pilot34' => 'gleb34@gmail.com' }
  s.source       = { :git => 'https://github.com/pilot34/P34Utils.git', :tag => '0.0.1' }
  s.platform     = :ios, '5.0'
  s.source_files = './**/*.{h,m}'
  s.resources = ''
  s.requires_arc = true
  s.dependency 'Nimbus'
  s.dependency 'UIDeviceAddition'
  s.dependency 'Reachability'
  s.dependency 'ASIHTTPRequest'
  s.dependency 'GoogleAnalytics-iOS-SDK'
  s.prefix_header_contents = '#import "P34Utils.h"'
  s.framework = 'CoreData'
  s.framework = 'CoreGraphics'
  s.framework = 'QuartzCore'
end