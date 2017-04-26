Ctws::Engine.routes.draw do
  namespace :v1 do
    resources :min_app_versions
    get 'min_app_version', to: 'min_app_versions#min_app_version'
  end
  namespace :v2 do
    # resources :min_app_versions
    get 'min_app_version', to: 'min_app_versions#min_app_version'
  end
  
  # match '/', :to => 'base#raise_not_found!', via: :all
  # match '*other', :to => 'base#raise_not_found!', via: :all

end
