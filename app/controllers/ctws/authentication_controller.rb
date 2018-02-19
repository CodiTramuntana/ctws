module Ctws
  class AuthenticationController < CtwsController
    skip_before_action :authorize_request, only: :authenticate

    # return auth token once user is authenticated
    def authenticate
      auth_token = Ctws::AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
      json_response auth_as_jsonapi(auth_token)
    end

    private

    def auth_as_jsonapi auth_token
      [{
        type: controller_name,
        attributes: {
          message: Ctws::Message.authenticated_user_success,
          auth_token: auth_token
        }
      }]
    end

    def auth_params
      params.permit(:email, :password)
    end
  end
end
