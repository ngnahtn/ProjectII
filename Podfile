# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Card Maker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Card Maker
	pod 'Firebase/Auth'
	pod 'Firebase/Firestore'

  target 'Card MakerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Card MakerUITests' do
    # Pods for testing
  end
  post_install do |pi|
      pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
  end

end
