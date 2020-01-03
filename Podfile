source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'PhotoAssassin' do

  pod 'R.swift'
  pod 'SwiftLint'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Functions'
  pod 'Firebase/Storage'
  pod 'FirebaseUI'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FBSDKLoginKit'
  pod 'GoogleSignIn'

  target 'PhotoAssassinTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end
