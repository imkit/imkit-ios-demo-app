# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'

target 'imkit-ios-sdk-v3-demo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'IQKeyboardManagerSwift', '6.5.6'
#  pod 'IMKit', :git => 'https://github.com/imkit/imkit-ios-framework-v3.git', :branch => 'swift5.5.2'
  pod 'IMKit', :git => 'https://github.com/imkit/imkit-ios-framework-v3.git', :branch => 'swift5.7'
  pod 'SwiftLinkPreview', :git => 'https://github.com/imkit/SwiftLinkPreview.git'
  pod 'ProgressHUD'

  target 'ShareExtension' do
    inherit! :search_paths
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
  end
end

