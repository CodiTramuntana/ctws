module Ctws
  class AuthenticateUser
    def initialize(email, password="12346")
      @email = email
      @password = password
    end

    # Service entry point
    def call
      Ctws::JsonWebToken.encode(user_id: user.id) if user

      # attrs_hash = {}
      # Ctws.jwt_auth_token_attrs.each {|a| attrs_hash.merge!({"user_#{a}": user.try(a)})}
      # Ctws::JsonWebToken.encode(attrs_hash) if user
    end

    private

    attr_reader :email, :password

    # verify user credentials
    def user
      user = if Ctws.user_authentication_callback.present?
        Ctws.user_authentication_callback.call(email, password)
      else
        Ctws.user_class.find_by(email: email)
      end

      return user if user && ensure_is_ctws_user_class(user)
      # raise Authentication error if credentials are invalid
      raise(Ctws::ExceptionHandler::AuthenticationError, Ctws::Message.invalid_credentials)
    end

    def ensure_is_ctws_user_class user
      return true if user.class.base_class == Ctws.user_class
      raise "user_authentication_callback does not match Ctws.user_class" unless Rails.env.production?
    end
  end
end
