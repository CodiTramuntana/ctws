# ctws

Rails gem to be used as Webservice RESTful JSON API with Rails 5.

With `MinAppVersion` and `User` resources, with token based authentication [JSON Web Tokens](https://jwt.io/).

## Usage
How to use my plugin.

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

By default the user model is `User` but you can change it by creating a `ctws.rb` initializer file in `config/initializers` and put this content in it:

```ruby 
Ctws.user_class = "Account"
```

The application `User` model **must have `email` and `password` attributes**.

For `password` validation [`ActiveModel::SecurePassword::InstanceMethodsOnActivation authenticate`](https://apidock.com/rails/v4.2.7/ActiveModel/SecurePassword/InstanceMethodsOnActivation/authenticate) and [`Devise::Models::DatabaseAuthenticatable#valid_password?`](http://www.rubydoc.info/github/plataformatec/devise/Devise%2FModels%2FDatabaseAuthenticatable:valid_password%3F) User instance methods are supported.

<!--
Change the app's models so that they know that they are supposed to act like ctws:

```ruby
# app/models/user.rb

class User < ApplicationRecord
  acts_as_ctws
end
```
-->

## Endpoints

| Endpoint                                           | Functionality                                    | Requires Authentication?  |
| -------------------------------------------------- | -----------------------------------------------: | :-----------------------: |
| `GET    /ctws/v1/min_app_version`                  | Get latest minimum app version for all platforms | No                        |
| `GET    /ctws/v1/min_app_versions`                 | List all min_app_versions                        | Yes                       |
| `GET    /ctws/v1/min_app_versions/:id `            | Get a min_app_version                            | Yes                       |
| `POST   /ctws/v1/min_app_versions`                 | Creates a min_app_version                        | Yes                       |
| `PUT    /ctws/v1/min_app_versions/:id`             | Updates a min_app_version                        | Yes                       |
| `DELETE /ctws/v1/min_app_versions/:id`             | Delete a min_app_version                         | Yes                       |
| `POST   /ctws/signup`                              | Signup                                           | No                        |
| `POST   /ctws/login`                               | Login                                            | No                        |


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