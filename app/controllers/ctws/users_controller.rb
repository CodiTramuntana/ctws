module Ctws
  class UsersController < CtwsController
    skip_before_action :authorize_request, only: :create
    
    # POST /signup
    # return authenticated token upon signup
    def create
      # We use Active Record's create! method so that in the event there's an error, 
      # an exception will be raised and handled in the exception handler.
      ctws_user = Ctws.user_class.create!(ctws_user_params)
      if Ctws.user_validate_with_password
        auth_token = Ctws::AuthenticateUser.new(ctws_user.email, ctws_user.password).call
      elsif !Ctws.user_validate_with_password
        auth_token = Ctws::AuthenticateUser.new(ctws_user.email).call
      end
      # response = { message: Ctws::Message.account_created, auth_token: auth_token }
      
      json_response(user_as_jsonapi(ctws_user, auth_token), :created)
    end
    
    private
    
    def user_as_jsonapi user, auth_token
      {
        type: ActiveModel::Naming.param_key(Ctws.user_class),
        id: user.id,
        attributes: {
          message: Ctws::Message.account_created, 
          auth_token: auth_token, 
          created_at: user.created_at
        }
      }
    end
    
    def ctws_user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
