Ctws.user_class = "User"
Ctws.user_class_strong_params = [:email, :password, :password_confirmation]
Ctws.jwt_expiration_time = 24.hours.from_now
Ctws.jwt_auth_token_attrs = %i(id email) # TODO: implement
Ctws.user_authentication_callback = nil
