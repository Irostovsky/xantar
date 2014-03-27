Rails.application.routes.draw do

  resources :post, only: [:index, :create, :new] do 
    resource :payment, only: :create
  end
  root :to => "posts#index"

end
