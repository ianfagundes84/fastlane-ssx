FASTLANE=$(BUNDLE) exec fastlane

# New App
create_app: ## create a new app 
	$(FASTLANE) create_new_app
	
# Certificates & Profiles
install_certificates: ## fetch and install certificates for code signing
	$(FASTLANE) fetch_certificates

renew_profiles: ## revoke and re-create provisioning profiles to include new devices
	$(FASTLANE) update_profiles

# Tests
execute_tests: ## run unit tests
	$(FASTLANE) unit_test

#Ad-Hoc builds
## Ex: make build_ipa CONFIG=WHITELABELSSX_DEV
build_ipa: ## builds the ipa file for config parameter (Ad Hoc)
	$(FASTLANE) build_ipa config:$(CONFIG)

# Test Flight builds
## Ex: make release_testflight CONFIG=WHITELABELSSX_DEV
release_testflight: ## builds for config scheme and sends it to Test Flight (Note: make sure version and build numbers and properly set)
	$(FASTLANE) release_alpha config:$(CONFIG)

generate_fastlane_sesssion: ## creates an 2FA authentication session to use on FASTLANE_SESSION to authenticate on AppStore Apis
# Will be necessary define a agent user in bitrise.
	$(FASTLANE) spaceauth