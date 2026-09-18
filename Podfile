# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'FiestonVirtual' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FiestonVirtual
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'

  target 'FiestonVirtualTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FiestonVirtualUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['CLANG_WARN_STRICT_PROTOTYPES'] = 'NO'
    end
  end
end
