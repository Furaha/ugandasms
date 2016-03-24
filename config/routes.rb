Rails.application.routes.draw do

  resources :users
  resources :regions
  resources :recipients
  resources :programs

  resources :messages do
    member do
      get 'transmit'
    end
  end

  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'regions#index'

  # resources :participants

  #resources :campaigns

  #match '/start_campaign', to: 'messages#start_campaign', via: :post, as: :start_campaign
  #match '/receive_texts', to: 'messages#receive_texts', via: :post, as: :receive_texts
  #  match 'send', to: 'messages#send', via: :get, as: :send

end
