Rails.application.routes.draw do

  post '/api/login',  to: 'sessions#login'
  post '/api/users',  to: 'users#create'
  get  '/api/current', to: 'users#current'

  scope :api do
    resources :articles, param: :slug, only: %i[show create update destroy]
  end
end
