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
    class NotConfirmed < StandardError; end
    class VerificationError < StandardError; end

    included do
      # Define custom handlers
      # 422 - Unprocessable Entity
      rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
      rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
      rescue_from ExceptionHandler::UnprocessableEntity, with: :four_twenty_two
      rescue_from ArgumentError, with: :four_twenty_two
      # 401 - Unauthorized
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      # 498 - Invalid Token
      rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
      # 404 - Not Found
      rescue_from ExceptionHandler::RoutingError, with: :not_found
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::RoutingError, with: :not_found
      rescue_from ExceptionHandler::NotConfirmed, with: :not_confirmed
      rescue_from ExceptionHandler::VerificationError, with: :four_ninety_eight
    end

    # JSON response with message; Status code 401 - Unauthorized
    def unauthorized_request(e)
      json_response(error_response_params(e, 401), :unauthorized)
    end

    # JSON response with message; Status code 404 - Not Found
    def not_found(e)
      json_response(error_response_params(e, 404), :not_found)
    end

    def not_confirmed(e)
      json_response(error_response_params(e, 403), :unauthorized)
    end

    # JSON response with message; Status code 422 - unprocessable entity
    def four_twenty_two(e)
      json_response(error_response_params(e, 422), :unprocessable_entity)
    end

    # JSON response with message; Status code 498 - Invalid Token
    def four_ninety_eight(e)
      json_response(error_response_params(e, 498), :invalid_token)
    end

    #------------------------------------------------------
    private
    #------------------------------------------------------

    def error_response_params(exception, error_code)
      [{ message: exception.message, error_code: error_code, data: exception.backtrace}]
    end

  end
end