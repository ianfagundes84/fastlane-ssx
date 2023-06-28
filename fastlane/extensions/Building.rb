require_relative '../values/configs'

platform :ios do
  desc "Build IPA for config"
  lane :build_ipa do |options|
    name = options[:config]
    raise "Invalid config: #{name}" unless config = getConfig(name)
    build_adhoc_ipa(config)
  end

  def build_adhoc_ipa(config)
    build_ipa(config, "ad-hoc", config.profile_adhoc)
  end

  def build_appstore_ipa(config)
    build_ipa(config, "app-store", config.profile_appstore)
  end

  def build_ipa(config, method, profile)
    project = ENV['XCODE_PROJECT_PATH'] || "WhiteLabel/WhiteLabel.xcodeproj"
    # UI.message "project: #{project}"
    # UI.message "File exists? #{File.exist?(project)}"
    version_number = get_version_number(xcodeproj: project, target: config.target)
    # UI.message "Version Number is?: #{version_number}"
    file_name = "#{config.scheme} (#{version_number} - #{$build_number}).ipa"
    # UI.message "config.scheme?: #{config.scheme}"

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
