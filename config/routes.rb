Rails.application.routes.draw do
  root 'campaigns#index'
  resources :campaigns
  match '/send_question', to: 'messages#send_questions', via: :post, as: :send_questions
  match '/recieve_texts', to: 'messages#recieve_texts', via: :post, as: :recieve_texts
end
