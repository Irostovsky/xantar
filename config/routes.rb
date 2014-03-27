Rails.application.routes.draw do

  resource :payment, only: [:create, :show]
  root :to => "payments#show"

end
