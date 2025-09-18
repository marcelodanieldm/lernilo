Rails.application.routes.draw do
  get "lernanto_home/index"
  get "administristo_home/index"
  get "profesoro_home/index"
  devise_for :users

  authenticated :user, ->(u) { u.profesoro? } do
    root to: 'profesoro_home#index', as: :profesoro_root
  end
  authenticated :user, ->(u) { u.administristo? } do
    root to: 'administristo_home#index', as: :administristo_root
  end
  authenticated :user, ->(u) { u.lernanto? } do
    root to: 'lernanto_home#index', as: :lernanto_root
  end
  authenticated :user, ->(u) { u.helpanto? } do
    root to: 'helpanto_home#index', as: :helpanto_root
  end

  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
