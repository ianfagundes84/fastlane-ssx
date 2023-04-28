require_relative 'bundle_ids'
require_relative 'firebase_ids'
require_relative 'profiles'

def getConfig(name)
  case name
  when "WHITELABELSSX_DEV"
    return Configs::WHITELABELSSX_DEV
  when "WHITELABELSSX_DEV_COPY"
    return Configs::WHITELABELSSX_DEV_COPY
  else
    return nil
  end
end

class Config
  attr_reader :id
  attr_reader :target
  attr_reader :scheme
  attr_reader :firebase_id
  attr_reader :profile_adhoc
  attr_reader :profile_appstore

  def initialize(id, target, scheme, firebase_id, profile_adhoc, profile_appstore)
    @id = id
    @target = target
    @scheme = scheme
    @firebase_id = firebase_id
    @profile_adhoc = profile_adhoc
    @profile_appstore = profile_appstore
  end
end

module Configs
  WHITELABELSSX_DEV = Config.new(
    Identifiers::WHITELABELSSX_DEV,
    "WhiteLabel",
    "WhiteLabel",
    FirebaseIds::WHITELABELSSX_DEV,
    # Profiles
    Profiles::WHITELABELSSX_DEV_ADHOC,
    Profiles::WHITELABELSSX_DEV_APPSTORE
  )
  WHITELABELSSX_DEV_COPY = Config.new(
    Identifiers::WHITELABELSSX_DEV_COPY,
    "WhiteLabelCopy",
    "WhiteLabel copy",
    FirebaseIds::WHITELABELSSX_DEV_COPY,
    # Profiles
    Profiles::WHITELABELSSX_APPSTORE_COPY_ADHOC,
    Profiles::WHITELABELSSX_APPSTORE_COPY
  )
end
