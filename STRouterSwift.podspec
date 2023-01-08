#
# Be sure to run `pod lib lint STRouterSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'STRouterSwift'
  s.version          = '0.1.0'
  s.summary          = 'Router.'

  s.description      = <<-DESC
基于URL进行路由.
                       DESC

  s.homepage         = 'https://github.com/STKits/STRouterSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cnjsyyb' => 'cnjsyyb@163.com' }
  s.source           = { :git => 'https://github.com/STKits/STRouterSwift.git', :tag => s.version.to_s }

  s.swift_versions = ['5.0']
  
  s.ios.deployment_target = '13.0'

  s.source_files = 'STRouterSwift/Classes/**/*'
end
