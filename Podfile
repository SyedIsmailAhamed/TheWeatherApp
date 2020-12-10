# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'TheWeatherApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TheWeatherApp
    pod 'ObjectMapper'
    pod 'Alamofire', '~> 4.8'
    pod 'SwiftMessages'
    pod 'ProgressHUD'
    pod 'RealmSwift'
    pod 'Unrealm'
    pod 'AlamofireImage'

  target 'TheWeatherAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TheWeatherAppUITests' do
    # Pods for testing
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      config.build_settings['SWIFT_SUPPRESS_WARNINGS'] = "YES"
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
    end
  end
end
