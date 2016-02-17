Rails.application.routes.draw do
  root 'campaigns#index'
  resources :campaigns
  match '/send_question', to: 'messages#send_questions', via: :post, as: :send_questions
  match '/receive_texts', to: 'messages#receive_texts', via: :post, as: :receive_texts
  resources :participants
end
