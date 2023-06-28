require_relative '../values/configs'

platform :ios do
  desc "Release an Alpha version on TestFlight for config"
  lane :release_alpha do |options|
    name = options[:config]
    # UI.message "Validate name of the app: #{name}"
    raise "Invalid config: #{name}" unless config = getConfig(name)
    release_to_testflight(config)
  end

  def release_to_testflight(config)
    auth_app_store_connect()

    $build_number = latest_testflight_build_number(app_identifier: config.id) + 1
    increment_build_number(xcodeproj: "#{ENV["BITRISE_SOURCE_DIR"]}/WhiteLabel.xcodeproj", build_number: $build_number)

    build_appstore_ipa(config)
    testflight(
      app_identifier: config.id,
      distribute_external: false,
      skip_submission: true,
      skip_waiting_for_build_processing: true
    )
  end
end
