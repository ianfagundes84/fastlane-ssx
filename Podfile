platform :ios, '12.0'

target 'WhiteLabel' do
  use_frameworks!
  # adicione os seus pods aqui
end

target 'WhiteLabel copy' do
  use_frameworks!
  # adicione os seus pods aqui
end

# Note que este bloco está fora das definições de target
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
