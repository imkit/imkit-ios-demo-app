platform :ios, '13'

target 'imkit-ios-sdk-v3-demo' do
  use_frameworks!

  pod 'IQKeyboardManagerSwift', '6.5.6'
  pod 'IMKit', :git => 'https://github.com/imkit/imkit-ios-framework-v3.git', :branch => 'swift5.10'
  pod 'SwiftLinkPreview', :git => 'https://github.com/imkit/SwiftLinkPreview.git'
  pod 'ProgressHUD'

  target 'ShareExtension' do
    inherit! :search_paths
  end  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
  installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
              end
        end
    end
end

