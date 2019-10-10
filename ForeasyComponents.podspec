#
# Be sure to run `pod lib lint ForeasyComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ForeasyComponents'
  s.version          = '0.1.4'
  s.summary          = '和易科技有限公司项目组件（iOS-Swift）'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
#和易科技有限公司项目组件（iOS-Swift）
#请在 Podfile 文件中添加:
#source 'https://github.com/diaoshihao/Specs.git'
#source 'https://github.com/CocoaPods/Specs.git'
                       DESC

  s.homepage         = 'https://github.com/diaoshihao/ForeasyComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'diaoshihao' => 'diaoshihao@icloud.com' }
  s.source           = { :git => 'https://github.com/diaoshihao/ForeasyComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_versions = '5.0'
  
  s.subspec 'Extensions' do |ex|
    ex.source_files = 'ForeasyComponents/Classes/Extensions/**/*.swift'
  end
  
  s.subspec 'ViewControl' do |control|
    control.source_files = 'ForeasyComponents/Classes/ViewControl/**/*.swift'
    control.dependency 'SnapKit'
    control.dependency 'ForeasyComponents/Extensions'
  end
  
  # s.resource_bundles = {
  #   'ForeasyComponents' => ['ForeasyComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
