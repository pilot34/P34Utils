Pod::Spec.new do |s|
  s.name         = 'P34Utils'
  s.version      = '0.0.8'
  s.summary      = 'Some useful utils classes.'
  s.homepage     = 'https://github.com/pilot34/P34Utils'
  s.license      = 'MIT'
  s.author       = { 'pilot34' => 'gleb34@gmail.com' }
  s.source       = { :git => 'https://github.com/pilot34/P34Utils.git', :branch => 'minimal' }
  s.platform     = :ios, '5.0'
  s.source_files = '**/*.{h,m}'
  s.requires_arc = true
  
  s.dependency 'Reachability'
  s.dependency 'AFNetworking', :version => '1.3.1'
  s.framework = 'CoreData'
  s.framework = 'CoreGraphics'
  s.framework = 'QuartzCore'
end