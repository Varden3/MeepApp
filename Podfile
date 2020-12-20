# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Nimble'
end

target 'MeepApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'RxGoogleMaps'
  
  # Pods for MeepApp

  target 'MeepAppTests' do
    inherit! :search_paths
    test_pods
    # Pods for testing
  end

  target 'MeepAppUITests' do
    # Pods for testing
  end

end
