#
# Be sure to run `pod lib lint ForeasyComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

# cocoapods 私有库基于 git 建立流程（SpecName，私有库名称，自定义）
# 1. 若无，创建私有索引库 SpecName 推送到远程地址
# 2. 若未关联，将私有库并关联到本地（命令：pod repo add SpecName 私有库 SpecName 的地址
# 3. 在项目中创建和配置 podspec 描述文件并验证无误（命令：pod spec create 项目名）
# 4. 提交本地代码到远端并设置tag，提交前验证 podspec（命令：pod lib lint 文件名.podspec）
# 5. 推送描述文件到远程私有库（命令：pod repo push SpecName 文件名.podspec）

# cocoapods 文件更新提交流程：
# 1. 修改版本号 s.version
# 2. 提交并推送到远程库，打上 tag（与版本号一致）
# 3. 推送描述文件 *.podspec到远端

#使用：请在 Podfile 文件中添加:
#source 'https://github.com/diaoshihao/Specs.git'
#source 'https://github.com/CocoaPods/Specs.git'

# 基于 svn ：s.source = { :svn => 'svn://120.27.144.18:9999/svn/iproject/trunk/ForeasyComponents', :tag => s.version.to_s }
   

Pod::Spec.new do |s|
  s.name             = 'ForeasyComponents'
  s.version          = '0.1.7'
  s.summary          = '和易科技有限公司项目组件（iOS-Swift）'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
#和易科技有限公司项目组件（iOS-Swift）

                    DESC

  s.homepage         = 'https://github.com/diaoshihao/ForeasyComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'diaoshihao' => 'diaoshihao@icloud.com' }
  s.source           = { :svn => 'svn://120.27.144.18:9999/svn/iproject/trunk/ForeasyComponents', :tag => s.version.to_s }
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
