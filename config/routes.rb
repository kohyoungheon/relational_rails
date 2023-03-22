Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get "/", to: "welcome#index"
  get "/garages", to: "garages#index"
  get "/garages/:id", to: "garages#show"
  
  get "/cars", to: "cars#index"
end
