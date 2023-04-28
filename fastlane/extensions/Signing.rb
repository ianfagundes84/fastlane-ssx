# Fastfile dedicated to signing configuration of iOS projects
require_relative '../values/bundle_ids'
require 'dotenv'
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
    match(git_branch: branch, app_identifier: bundle_ids, type: "development")
    match(git_branch: branch, app_identifier: bundle_ids, type: "appstore")
  end

  def update_profiles(branch, bundle_ids)
    auth_app_store_connect()
    match(readonly: false, force_for_new_devices: true, git_branch: branch, app_identifier: bundle_ids, type: "development")
    match(readonly: false, git_branch: branch, app_identifier: bundle_ids, type: "appstore")
  end
end