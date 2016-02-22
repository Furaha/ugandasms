Rails.application.routes.draw do
  root 'campaigns#index'
  resources :campaigns
  match '/start_campaign', to: 'messages#start_campaign', via: :post, as: :start_campaign
  match '/receive_texts', to: 'messages#receive_texts', via: :post, as: :receive_texts
  resources :participants
end
