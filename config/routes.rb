Rails.application.routes.draw do
  root 'welcome#homepage'
  # root 'services#index'
  resources :reservations
  resources :services
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  resources :users


 resources :users, only: [:create] do
  resource :password,
  controller: "clearance/passwords",
  only: [:create, :edit, :update]
  end

resource :session, :controller => 'sessions'
delete '/sign_out' => 'sessions#destroy', as: 'log_out'


end
