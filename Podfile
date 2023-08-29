# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'WhiteLabel' do
  
  use_frameworks!
  
end

target 'WhiteLabel copy' do
  
  use_frameworks!
  
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
    config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
  end
end
