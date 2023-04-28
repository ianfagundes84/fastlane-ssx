require_relative 'bundle_ids'

module Profiles
  WHITELABELSSX_DEV_ADHOC = "match AdHoc #{Identifiers::WHITELABELSSX_DEV}"
  WHITELABELSSX_DEV_APPSTORE = "match AppStore #{Identifiers::WHITELABELSSX_DEV}"
  WHITELABELSSX_APPSTORE_COPY_ADHOC = "match AdHoc #{Identifiers::WHITELABELSSX_DEV_COPY}"
  WHITELABELSSX_APPSTORE_COPY = "match AppStore #{Identifiers::WHITELABELSSX_DEV_COPY}"
end
