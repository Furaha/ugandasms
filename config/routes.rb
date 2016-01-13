Rails.application.routes.draw do
  root 'campaigns#index'
  resources :campaigns
end
