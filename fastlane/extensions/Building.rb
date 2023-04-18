# Fastfile dedicated to signing configuration of iOS projects
require_relative '../values/configs'

platform :ios do
  desc "Build IPA for config"
  lane :build_ipa do |options|
    p options
    name = options[:config]
    UI.user_error!("Invalid config: #{name}") unless config = getConfig(name)
    build_adhoc_ipa(config)
  end

  def build_appstore_ipa(config)
    build_ipa(config, "app-store", config.profile_appstore)
  end

  def build_ipa(config, method, profile)
    project = "App/App.xcodeproj"
    version_number = get_version_number(xcodeproj: project, target: config.target)
    file_name = "#{config.scheme} (#{version_number} - #{$build_number}).ipa"

    gym(
      scheme: config.scheme,
      export_method: method,
      export_options: {
        method: method,
        provisioningProfiles: { config.id => profile }
      },
      output_directory: "output/ipa",
      output_name: file_name
    ) 
  end
end