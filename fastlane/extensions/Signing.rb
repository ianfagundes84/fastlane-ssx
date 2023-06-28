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
    api_key_path = options[:api_key_path]
    fetch_certificates(target_name, [Identifiers::WHITELABELSSX_DEV], api_key_path) # Whitelabel     
    fetch_certificates(target_name, [Identifiers::WHITELABELSSX_DEV_COPY], api_key_path) # Whitelabel copy
  end
  

  desc "Update profiles on apple developer portal when adding new devices"
  lane :update_profiles do |options|
    target_name = options[:target_name]
    update_profiles(target_name, [Identifiers::WHITELABELSSX_DEV])
    update_profiles(target_name, [Identifiers::WHITELABELSSX_DEV_COPY]) 
  end

  def fetch_certificates(branch, bundle_ids, api_key_path)
    match(git_branch: branch, app_identifier: bundle_ids, type: "development", api_key_path: api_key_path)
    match(git_branch: branch, app_identifier: bundle_ids, type: "appstore", api_key_path: api_key_path)
  end

end
