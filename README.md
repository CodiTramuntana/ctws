# ctws

Rails gem to be used as Webservice RESTful JSON API with Rails 5.

With `MinAppVersion` resource, and token based authentication with [JSON Web Tokens](https://jwt.io/).

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
server.

##  Engine setup

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

## Endpoints

| Endpoint                                           | Functionality                                    | Requires Authentication?  |
| -------------------------------------------------- | -----------------------------------------------: | :-----------------------: |
| `GET    /ws/v1/min_app_version`                    | Get latest minimum app version for all platforms | No                        |
| `GET    /ws/v1/min_app_versions`                   | List all min_app_versions                        | Yes                       |
| `GET    /ctws/v1/min_app_versions/:id `            | Get a min_app_version                            | Yes                       |
| `POST   /ctws/v1/min_app_versions`                 | Creates a min_app_version                        | Yes                       |
| `PUT    /ctws/v1/min_app_versions/:id`             | Updates a min_app_version                        | Yes                       |
| `DELETE /ctws/v1/min_app_versions/:id`             | Delete a min_app_version                         | Yes                       |
| `POST   /v1/signup`                                | Signup                                           | No                        |
| `POST   /v1/login`                                 | Login                                            | No                        |


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