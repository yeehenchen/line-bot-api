Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'benjamin/webhook', to: 'benjamin#webhook'

  resources :links
  resources :channels, only: [:new, :create]
end
