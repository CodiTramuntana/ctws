require_dependency "ctws/application_controller"

module Ctws
  class UsersController < CtwsController
    skip_before_action :authorize_request, only: :create
    
    # POST /signup
    # return authenticated token upon signup
    def create
      # We use Active Record's create! method so that in the event there's an error, 
      # an exception will be raised and handled in the exception handler.
      ctws_user = Ctws::User.create!(ctws_user_params)
      auth_token = Ctws::AuthenticateUser.new(ctws_user.email, ctws_user.password).call
      response = { message: Ctws::Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end
    
    private
    
    def ctws_user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
