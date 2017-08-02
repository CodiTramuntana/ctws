require "ctws/engine"

module Ctws
  mattr_accessor :user_class
  mattr_accessor :user_class_strong_params
  mattr_accessor :user_validate_with_password
  mattr_accessor :jwt_expiration_time
  mattr_accessor :jwt_auth_token_attrs

  def self.user_class
    @@user_class.constantize
  end
  
  def self.jwt_auth_token_attrs
    # TODO: implement
    @@jwt_auth_token_attrs
  end
end
