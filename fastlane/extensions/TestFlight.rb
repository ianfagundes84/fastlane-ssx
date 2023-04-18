# Fastfile dedicated to uploading builds to TestFlight (iTunes Connect)
require_relative '../values/configs'

platform :ios do
  desc "Release an Alpha version on TestFlight for config"
  lane :release_alpha do |options|
    name = options[:config]
    UI.user_error!("Invalid config: #{name}") unless config = getConfig(name)
    release_to_testflight(config)
  end

  def release_to_testflight(config)
    auth_app_store_connect()

    $build_number = latest_testflight_build_number(app_identifier: config.id) + 1
    increment_build_number(xcodeproj: "App/App.xcodeproj", build_number: $build_number)

    build_appstore_ipa(config)
    testflight(
      app_identifier: config.id,
      distribute_external: false,
      skip_submission: true,
      skip_waiting_for_build_processing: true
    )
    upload_symbols(config)
  end
  
  # Upload DSYMs to Firebase
  def upload_symbols(config)
    upload_symbols_to_crashlytics(
      app_id: config.firebase_id,
      platform: 'ios',
      dsym_worker_threads: "10"
    )
  end
end