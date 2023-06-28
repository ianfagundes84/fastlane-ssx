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
    api_key_path = recreate_api_key_file
    match(git_branch: branch, app_identifier: bundle_ids, type: "development", api_key_path: api_key_path)
    match(git_branch: branch, app_identifier: bundle_ids, type: "appstore", api_key_path: api_key_path)
end
  
# def recreate_api_key_file
#     api_key_json = ENV["APPSTORECONNECT_API_KEY_JSON"]
#     api_key_hash = JSON.parse(api_key_json)
#     file_path = File.expand_path("AppStoreConnectAPIKey.json") 
#     File.open(file_path, "w") do |f|
#         f.write(api_key_hash.to_json)
#     end
#     return file_path
# end
def recreate_api_key_file
  # Add the file path of your JSON file
  file_path = 'AppStoreConnectAPIKey.json'
  
  # Print out a statement indicating that file is about to be read
  puts "Reading file: #{file_path}"
  
  # Read the file's contents
  file_contents = File.read(file_path)
  
  # Print out the contents of the file
  puts "File contents: #{file_contents}"
  
  # Continue with your existing code...
  
  # existing code here
  # json_contents = JSON.parse(file_contents)
  # ...

  # Rescuing the JSON::ParserError to provide more debug information
  begin
    json_contents = JSON.parse(file_contents)
  rescue JSON::ParserError => e
    puts "Failed to parse JSON due to #{e.message}"
    # Reraise the exception
    raise
  end
end

end