# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TopicDemos' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Stripe/ApplePay'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  pod 'SwiftyJSON'
  pod 'SDWebImage', '~> 3.8.2'
  pod 'AFNetworking', '~> 3.0.4'
  swift_version = "3.0"
  pod "PromiseKit", "~> 4.0"
  # Pods for TopicDemos

  target 'TopicDemosTests' do
    #inherit! :search_paths
    inherit! :complete
    pod 'KIF', :configurations => ['Debug']
    # Pods for testing
  end

  target 'TopicDemosUITests' do
    inherit! :search_paths

  pod 'Firebase/Core'
    pod 'KIF', :configurations => ['Debug']
#    pod 'KIF/IdentifierTests'
    # Pods for testing
  end

end

target 'TopicDemosWatchApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TopicDemosWatchApp

end

target 'TopicDemosWatchApp Extension' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TopicDemosWatchApp Extension

end
