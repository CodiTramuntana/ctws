Rails.application.routes.draw do
  get 'user/create'

  mount Ctws::Engine => "/ctws"
end
