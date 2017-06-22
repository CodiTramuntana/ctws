module Ctws
  class AuthorizeApiRequest
    def initialize(headers = {})
      @headers = headers
    end

    # Service entry point - return valid user object
    def call
      {
        user: user
      }
    end

    private

    attr_reader :headers

    def user
      # check if user is in the database
      # memoize user object
      @user ||= Ctws.user_class.find(decoded_auth_token[:user_id]) if decoded_auth_token
      # handle user not found
    rescue ActiveRecord::RecordNotFound => e
      # raise custom error
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Ctws::Message.invalid_token} #{e.message}")
      )
    end

    # decode authentication token
    def decoded_auth_token
      @decoded_auth_token ||= Ctws::JsonWebToken.decode(http_auth_header)
    end

    # check for token in `Authorization` header
    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end
        raise(ExceptionHandler::MissingToken, Ctws::Message.missing_token)
    end
  end
end