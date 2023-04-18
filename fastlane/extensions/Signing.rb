# Fastfile dedicated to signing configuration of iOS projects
require_relative '../values/bundle_ids'
require 'dotenv'
Dotenv.load

platform :ios do
  desc "Fetch the Development, Distribution Certificates"
  lane :fetch_certificates do
    fetch_certificates("whitelabel", [Identifiers::WHITELABELSSX_DEV]) 
  end

  desc "Update profiles on apple developer portal when adding new devices"
  lane :update_profiles do
    if prompt(text: "Ao realizar esse procedimento, os profiles atuais serão revogados e substituídos, deseja continuar?", boolean: true)
      update_profiles("whitelabel", [Identifiers::WHITELABELSSX_DEV]) 
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