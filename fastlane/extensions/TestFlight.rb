# Fastfile dedicated to uploading builds to TestFlight (iTunes Connect)
require_relative '../values/configs'

platform :ios do
  desc "Release an Alpha version on TestFlight for config"
  lane :release_alpha do |options|
    name = options[:config]
    puts "Validate name of the app: #{name}"
    UI.user_error!("Invalid config: #{name}") unless config = getConfig(name)
    release_to_testflight(config)
  end

  def release_to_testflight(config)
    auth_app_store_connect()

    $build_number = latest_testflight_build_number(app_identifier: config.id) + 1
    increment_build_number(xcodeproj: "/Users/ianfagundes/Desktop/workspace/WhiteLabel/WhiteLabel.xcodeproj", build_number: $build_number)

    build_appstore_ipa(config)
    testflight(
      app_identifier: config.id,
      distribute_external: false,
      skip_submission: true,
      skip_waiting_for_build_processing: true
    )
  end
end