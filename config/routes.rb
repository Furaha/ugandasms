Rails.application.routes.draw do
  get 'users/new'

  root 'regions#index'

  resources :regions

  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :participants

  #resources :campaigns

  #match '/start_campaign', to: 'messages#start_campaign', via: :post, as: :start_campaign
  #match 'send_question', to: 'messages#send_question', via: :post, as: :send_question
  #match '/receive_texts', to: 'messages#receive_texts', via: :post, as: :receive_texts


end
