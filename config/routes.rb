Rails.application.routes.draw do
  root 'welcome#homepage'
  resources :business_hours
  resources :service_types
  resources :contents
  resources :businesses
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  

  resources :reservations
  resources :services
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  resources :users


  resources :users, only: [:create] do
  resource :password,
  controller: "clearance/passwords",
  only: [:create, :edit, :update]
  end

  # redirecting clearance to sessions
  resource :session, :controller => 'sessions'
  delete '/sign_out' => 'sessions#destroy', as: 'log_out'
  post '/session' =>'sessions#create', as: nil

end
