Ctws.user_class = "User"
Ctws.device_class = "DeviceApp"
Ctws.profile_class = "Profile"
Ctws.user_class_strong_params = [:email, :password, :password_confirmation]
Ctws.user_validate_with_password = true
Ctws.jwt_expiration_time = 24.hours.from_now
Ctws.jwt_auth_token_attrs = %i(id email) # TODO: implement
