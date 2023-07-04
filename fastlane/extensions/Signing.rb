# Fastfile dedicated to signing configuration of iOS projects
require_relative '../values/bundle_ids'
require 'dotenv'
require 'json'
require 'tempfile'

Dotenv.load

platform :ios do
  desc "Fetch the Development, Distribution Certificates"
  lane :fetch_certificates do |options|
    target_name = options[:target_name]
    fetch_certificates(target_name, [Identifiers::WHITELABELSSX_DEV]) # Whitelabel     
    fetch_certificates(target_name, [Identifiers::WHITELABELSSX_DEV_COPY]) # Whitelabel copy
  end
  

  desc "Update profiles on apple developer portal when adding new devices"
  lane :update_profiles do |options|
    target_name = options[:target_name]
    update_profiles(target_name, [Identifiers::WHITELABELSSX_DEV])
    update_profiles(target_name, [Identifiers::WHITELABELSSX_DEV_COPY]) 
  end

  def fetch_certificates(branch, bundle_ids)
    username = ENV["FASTLANE_USER"]
    password = ENV["FASTLANE_PASSWORD"]

    match(git_branch: branch, app_identifier: bundle_ids, type: "development", username: username, git_basic_authorization: Base64.strict_encode64("#{username}:#{password}"))
    match(git_branch: branch, app_identifier: bundle_ids, type: "appstore", username: username, git_basic_authorization: Base64.strict_encode64("#{username}:#{password}"))
  end

end
