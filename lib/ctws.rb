require "ctws/engine"

module Ctws
  mattr_accessor :user_class
  mattr_accessor :user_class_strong_params
  mattr_accessor :jwt_expiration_time
  mattr_accessor :jwt_auth_token_attrs
  # if nil or false user password won't be checked
  # user_authentication_callback will be called with email and password arguments.
  mattr_accessor :user_authentication_callback

  def self.user_class
    @@user_class.constantize
  end

  def self.jwt_auth_token_attrs
    # TODO: implement
    @@jwt_auth_token_attrs
  end
end
