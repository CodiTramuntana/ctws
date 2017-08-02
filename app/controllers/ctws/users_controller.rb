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
      
      json_response(ctws_user.created_as_jsonapi({"#{ctws_user.model_name.singular}": ctws_user, token: auth_token}), :created)
    end
    
    private
    
    def ctws_user_params
      params.permit(Ctws.user_class_strong_params)
    end
  end
end