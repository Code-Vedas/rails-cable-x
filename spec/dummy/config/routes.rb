Rails.application.routes.draw do
  mount CableX::Engine.server => "/cable_x"
  root 'root#index'
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
