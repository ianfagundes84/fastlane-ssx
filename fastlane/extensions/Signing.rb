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
    if prompt(text: "Ao realizar esse procedimento, os profiles atuais serão revogados e substituídos, deseja continuar?", boolean: true)
      update_profiles(target_name, [Identifiers::WHITELABELSSX_DEV])
      update_profiles(target_name, [Identifiers::WHITELABELSSX_DEV_COPY]) 
    end
  end

  def fetch_certificates(branch, bundle_ids)
    recreate_api_key_file
    match(git_branch: branch, app_identifier: bundle_ids, type: "development", api_key_path: "AppStoreConnectAPIKey.json")
    match(git_branch: branch, app_identifier: bundle_ids, type: "appstore", api_key_path: "AppStoreConnectAPIKey.json")
  end
  
  def recreate_api_key_file
    api_key_json = ENV["APPSTORECONNECT_API_KEY_JSON"]
    api_key_hash = JSON.parse(api_key_json)
    File.open("AppStoreConnectAPIKey.json","w") do |f|
      f.write(api_key_hash.to_json)
    end
  end
end