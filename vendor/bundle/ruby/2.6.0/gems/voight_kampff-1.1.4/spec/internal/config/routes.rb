Rails.application.routes.draw do
  resources :replicants, only: :index
  root to: 'replicants#index'
end
