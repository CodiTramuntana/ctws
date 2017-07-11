Ctws::Engine.routes.draw do
  namespace :v1 do
    resources :min_app_versions
    get 'min_app_version', to: 'min_app_versions#min_app_version'
    post 'signup', to: 'users#create'
    post 'login', to: 'authentication#authenticate'
  end
  namespace :v2 do
    # resources :min_app_versions
    get 'min_app_version', to: 'min_app_versions#min_app_version'
  end
  
  get '*unmatched_route', to: 'ctws#raise_not_found!'

  # match '/', :to => 'base#raise_not_found!', via: :all
  # match '*other', :to => 'base#raise_not_found!', via: :all

end
