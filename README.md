# ctws

[![Gem Version](https://badge.fury.io/rb/ctws.png)](https://badge.fury.io/rb/ctws)

Rails gem to be used as Webservice RESTful JSON API with Rails 5.

Features:
- `MinAppVersion` and `User` resources
- token based authentication [JSON Web Tokens](https://jwt.io/).
- Json Api

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ctws'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install ctws
```

## Mounting the Engine

To make the `ctws` engine's functionality accessible from within your application, it needs to be mounted in that application's `config/routes.rb` file:

```ruby
mount Ctws::Engine, at: "/ws"
```

This line will mount the engine at `/ws` in the application. Making it accessible at `http://localhost:3000/ws` when the application runs with rails
server. It can be whatever you want.

## Engine setup

The engine contains migrations for the `ctws_min_app_version` and `xxx` table which need to be created in the application's database so that the engine's models can query them correctly.
To copy these migrations into the application run the following command from the Rails App root, then run these migrations:

```bash
rails ctws:install:migrations
rails db:migrate
```

If you want to revert engine's migrations before removing it. To revert all migrations from blorgh engine you can run code such as:

```bash
bin/rails db:migrate SCOPE=ctws VERSION=0
```

### Hook the application `User` model with the engine

By default the user model is `User` but you can change it by creating or editing the `ctws.rb` initializer file in `config/initializers` and put this content in it:

```ruby
Ctws.user_class = "Account"
```

The application `User` model **must have the `email` attribute**.

The **`password` is optional** by default a user is validated with password, for `password` validation [`ActiveModel::SecurePassword::InstanceMethodsOnActivation authenticate`](https://apidock.com/rails/v4.2.7/ActiveModel/SecurePassword/InstanceMethodsOnActivation/authenticate) and [`Devise::Models::DatabaseAuthenticatable#valid_password?`](http://www.rubydoc.info/github/plataformatec/devise/Devise%2FModels%2FDatabaseAuthenticatable:valid_password%3F) User instance methods are supported.
<!--
To opt out the user validation with the password change it by creating or editing the `ctws.rb` initializer file in `config/initializers` and put this content in it: -->

To enable user validation with a password and verify that the user meets certain characteristics (such as being confirmed), you must create or edit the `ctws.rb` initializer file  at `config/initializers` and write something similar to the following:

```ruby
Ctws.user_authentication_callback = ->(user_email, user_password) do
  user = User.find_by(email: user_email)
  return user if user.try(:valid_password?, user_password) && user.enabled?
end
```

If you don't put this content, the validation of the user will only be by email.

You can edit your app's required fields for signup by creating or editing the `ctws.rb` initializer file in `config/initializers` and put your strong parameters:

```ruby
Ctws.user_class_strong_params = [:email, :password, :password_confirmation]
```

### Set the `JWT` expiry time

By default the token expiry time is 24h but you can change it by creating or editing the `ctws.rb` initializer file in `config/initializers` and put this content in it:

```ruby
Ctws.jwt_expiration_time = 24.hours.from_now
```

<!--
Change the app's models so that they know that they are supposed to act like ctws:

```ruby
# app/models/user.rb

class User < ApplicationRecord
  acts_as_ctws
end
```
-->

### Response messages in users' locale (i18n)

In your app set your accepted languages, add to `application.rb`:

```
config.i18n.available_locales = %w(en es fr ca)
```

## Endpoints

| Endpoint                                           | Functionality                                    | Requires Authentication?  |
| -------------------------------------------------- | -----------------------------------------------: | :-----------------------: |
| `GET    /ctws/v1/min_app_version`                  | Get latest minimum app version for all platforms | No                        |
| `POST   /ctws/signup`                              | Signup                                           | No                        |
| `POST   /ctws/login`                               | Login                                            | No                        |
<!--
| `GET    /ctws/v1/min_app_versions`                 | List all min_app_versions                        | Yes                       |
| `GET    /ctws/v1/min_app_versions/:id `            | Get a min_app_version                            | Yes                       |
| `POST   /ctws/v1/min_app_versions`                 | Creates a min_app_version                        | Yes                       |
| `PUT    /ctws/v1/min_app_versions/:id`             | Updates a min_app_version                        | Yes                       |
| `DELETE /ctws/v1/min_app_versions/:id`             | Delete a min_app_version                         | Yes                       |
-->

### min_app_version

**request:**

```bash
curl localhost:3000/ws/v1/min_app_version
```

**response:**

```json
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/vnd.api+json; charset=utf-8
ETag: W/"8dcf1379b7ee203a6d72b3c7773d47f4"
Transfer-Encoding: chunked
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c1924546-0212-45fe-b86a-83ee3a3b2fa4
X-Runtime: 0.003897
X-XSS-Protection: 1; mode=block

{
  "data": [
    {
      "id": 3,
      "type": "min_app_version",
      "attributes": {
        "codename": "Second release",
        "description": "Second release Description text",
        "min_version": "0.0.2",
        "platform": "android",
        "store_uri": "htttps://fdsafdsafdsaf.cot",
        "updated_at": "2017-06-22T17:53:31.252+02:00"
      }
    },
    {
      "type": "min_app_version",
      "id": 1,
      "attributes": {
        "codename": "First Release",
        "description": "You need to update your app. You will be redirected to the corresponding store",
        "min_version": "0.0.1",
        "platform": "ios",
        "store_uri": "https://itunes.apple.com/",
        "updated_at": "2017-06-21T14:29:59.348+02:00"
      }
    }
  ]
}
```
### signup

**request:**

```bash
curl -X POST -F "email=user@example.com" -F "password=123456789" http://localhost:3000/ws/v1/signup
```

**Successful response:**

```json
HTTP/1.1 201 Created
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/vnd.api+json; charset=utf-8
ETag: W/"ab43e77c2d67636c5c0cd707e661c311"
Transfer-Encoding: chunked
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 75f9d9cc-4ce2-4aed-9349-e995bb122f39
X-Runtime: 1.727068
X-XSS-Protection: 1; mode=block

{
  "data": {
    "type": "user",
    "id": 20,
    "attributes": {
      "message": "Account created successfully",
      "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMCwiZXhwIjoxNDk5ODU1MjQ5fQ.H9ljjShWOAv8b9xn9ZLKv-zgmH8xkPe6dkdhH4JrJPw",
      "created_at": "2017-07-11T12:27:27.916+02:00"
    }
  }
}
```

**Error response:**

```json
HTTP/1.1 401 Unauthorized
Cache-Control: no-cache
Content-Type: application/vnd.api+json; charset=utf-8
Transfer-Encoding: chunked
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b0d91125-446d-4ed3-95cb-4a702ee24289
X-Runtime: 0.091940
X-XSS-Protection: 1; mode=block

{
    "errors": {
        "message": "Invalid credentials"
    }
}
```

### login

**request:**

```bash
curl -X POST -F "email=user@example.com" -F "password=123456789" http://localhost:3000/ws/v1/login
```

**Successful response:**

```json
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/vnd.api+json; charset=utf-8
ETag: W/"4e7a5faaf9eb480a7a7dadb734d01da1"
Transfer-Encoding: chunked
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 565a8015-9087-480c-b5b6-1dbf634c7d83
X-Runtime: 0.278055
X-XSS-Protection: 1; mode=block

{
  "data": {
    "type": "authentication",
    "attributes": {
      "message": "Authenticated user successfully",
      "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNiwiZXhwIjoxNDk5ODU2MDgyfQ.FOLNcInu0yxnp_dqVnyzfzGNwKyv_ERoflhW4cvTa60"
    }
  }
}
```

**Error response:**

```json
HTTP/1.1 401 Unauthorized
Cache-Control: no-cache
Content-Type: application/vnd.api+json; charset=utf-8
Transfer-Encoding: chunked
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e95e4b63-3a83-409f-bd05-4cf2dea6136a
X-Runtime: 0.015463
X-XSS-Protection: 1; mode=block

{
    "errors": {
        "message": "Invalid credentials"
    }
}
```

## Tests

running `rspec` will run tests and output a report, first run migrations the tests:

```bash
rails db:migrate RAILS_ENV=test
rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

`ctws` is Copyright © 2017 CodiTramuntana SL. It is free software, and may be redistributed under the terms specified in the LICENSE file.

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# About CodiTramuntana

![CodiTramuntana's Logo](https://avatars0.githubusercontent.com/u/27996979?v=3&u=b0256e23ae7b2f237e3d1b5f2b2abdfe3092b24c&s=400)

Maintained by [CodiTramuntana](http://www.coditramuntana.com).

The names and logos for CodiTramuntana are trademarks of CodiTramuntana SL.

We love open source software!
