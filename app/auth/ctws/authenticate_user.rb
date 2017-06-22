module Ctws
  class AuthenticateUser
    def initialize(email, password)
      @email = email
      @password = password
    end
    
    # Service entry point
    def call
      Ctws::JsonWebToken.encode(user_id: user.id) if user
    end
    
    private
    
    attr_reader :email, :password
    
    # verify user credentials
    def user
      user = Ctws.user_class.find_by(email: email)
      
      # try method of  Active Record's has_secure_password or Devise valid_password?
      authenticated = user.try(:authenticate, password) || user.try(:valid_password?, password)
      
      return user if user && authenticated
      # raise Authentication error if credentials are invalid
      raise(Ctws::ExceptionHandler::AuthenticationError, Ctws::Message.invalid_credentials)
    end
    end
end