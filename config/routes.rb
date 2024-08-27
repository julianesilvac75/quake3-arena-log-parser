Rails.application.routes.draw do
  root "logs#index"

  get "logs", to: "logs#index"
  get "players", to: "players#index"
  get "death-means", to: "death_means#index"
  get "not_found", to: "errors#not_found"

  resources :matches
  get "matches/:id/kills", to: "matches#kills"
  # get "logs/parse", to: "logs#parse"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
