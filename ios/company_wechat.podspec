#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'company_wechat'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.vendored_libraries  = 'Assets/*.{a}'
  s.source_files = 'Classes/**/*', 'Assets/**/*'
  s.public_header_files = 'Classes/**/*.h', 'Assets/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

