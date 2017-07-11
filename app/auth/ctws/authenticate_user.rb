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
      user = Ctws.user_class.find_by(email: email)
      
      if Ctws.user_validate_with_password
        # try method of  Active Record's has_secure_password or Devise valid_password?
        authenticated = user.try(:authenticate, password) || user.try(:valid_password?, password)
      elsif !Ctws.user_validate_with_password
        authenticated = true
      end
      return user if user && authenticated
      # raise Authentication error if credentials are invalid
      raise(Ctws::ExceptionHandler::AuthenticationError, Ctws::Message.invalid_credentials)
    end
  end
end