Rails.application.routes.draw do

  resources :posts, only: [:index, :create, :new] do
    resource :payment, only: :create
  end
  root :to => "posts#index"

end
