module Ctws
  class JsonWebToken
    require 'jwt'

    # secret to encode and decode token
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = Ctws.jwt_expiration_time)
      # set expiry to 24 hours from creation time
      payload[:exp] = exp.to_i
      # sign token with application secret
      JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
      # get payload; first index in decoded Array
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
      # rescue from expiry exception
      rescue JWT::ExpiredSignature => e
        # raise custom error to be handled by custom handler
        raise Ctws::ExceptionHandler::ExpiredSignature, e.message
      rescue JWT::VerificationError => e
        # raise custom error to be handled by custom handler
        raise Ctws::ExceptionHandler::VerificationError, Ctws::Message.invalid_token

    end
  end
end
