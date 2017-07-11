module Ctws
  #  In the case where the record does not exist, 
  # ActiveRecord will throw an exception ActiveRecord::RecordNotFound. 
  # We'll rescue from this exception and return a 404 message.
  # List of Rails Status Code Symbols http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols
  
  module ExceptionHandler
    # provides the more graceful `included` method
    extend ActiveSupport::Concern
    
    # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
    class ExpiredSignature < StandardError; end
    class UnprocessableEntity < StandardError; end
    class RoutingError < StandardError; end

    included do
      # Define custom handlers
      rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
      rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
      rescue_from ExceptionHandler::UnprocessableEntity, with: :four_twenty_two
      rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
      rescue_from ExceptionHandler::RoutingError, with: :not_found
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::RoutingError, with: :not_found
      
      rescue_from ActiveRecord::RecordInvalid do |e|
        json_response({ message: e.message }, :unprocessable_entity)
      end
    end
    
    # JSON response with message; Status code 401 - Unauthorized
    def unauthorized_request(e)
      json_response({ message: e.message }, :unauthorized)
    end
    
    # JSON response with message; Status code 401 - Unauthorized
    def not_found(e)
      json_response({ message: e.message }, :not_found)
    end
    
    # JSON response with message; Status code 422 - unprocessable entity
    def four_twenty_two(e)
      json_response({ message: e.message }, :unprocessable_entity)
    end

    
    # JSON response with message; Status code 498 - Invalid Token
    def four_ninety_eight(e)
      json_response({ message: e.message }, :invalid_token)
    end
    
  end
end