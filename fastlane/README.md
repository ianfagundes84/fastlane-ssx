fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios build_ipa

```sh
[bundle exec] fastlane ios build_ipa
```

Build IPA for config

### ios fetch_certificates

```sh
[bundle exec] fastlane ios fetch_certificates
```

Fetch the Development, Distribution Certificates

### ios update_profiles

```sh
[bundle exec] fastlane ios update_profiles
```

Update profiles on apple developer portal when adding new devices

### ios release_alpha

```sh
[bundle exec] fastlane ios release_alpha
```

Release an Alpha version on TestFlight for config

### ios create_new_app

```sh
[bundle exec] fastlane ios create_new_app
```

Ask a name for the new app

### ios auth_app_store_connect

```sh
[bundle exec] fastlane ios auth_app_store_connect
```

Create a new app on App Store Connect

Authenticate with AppStoreConnect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
