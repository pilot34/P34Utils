Pod::Spec.new do |s|
  s.name         = 'P34Utils'
  s.version      = '0.1.0'
  s.summary      = 'Some useful utils classes.'
  s.homepage     = 'https://github.com/pilot34/P34Utils'
  s.license      = 'MIT'
  s.author       = { 'pilot34' => 'gleb34@gmail.com' }
  s.source       = { :git => 'https://github.com/pilot34/P34Utils.git', :branch => 'light' }
  s.platform     = :ios, '8.0'
  s.source_files = '*.{h,m}', 'P34Utils/*.{h,m}'
  s.requires_arc = true

  s.dependency 'Reachability'
end