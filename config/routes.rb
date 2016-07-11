require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Not Rails 5.0.0 ready as of yet
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Sidekiq web interface
  mount Sidekiq::Web => '/sidekiq'

  root 'products#index'
  get 'products/:id/buy' => 'products#buy'
  post 'newsletter/subscribe' => 'newsletter#subscribe', as: :subscribe
  get 'newsletter/confirm/:id' => 'newsletter#confirm'
end
