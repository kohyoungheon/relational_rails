Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get "/", to: "welcome#index"
  get "/garages", to: "garages#index"
  get "/garages/new", to: "garages#new"
  get "/garages/:id", to: "garages#show"
  get "/garages/:id/cars", to: "garages/cars#index"
  post "/garages", to: "garages#create"
  get "/garages/:id/edit", to: "garages#edit"
  patch "/garages/:id", to: "garages#update"
  get "/garages/:id/cars/new", to: "garages/cars#new"
  post "/garages/:id/cars", to: "garages/cars#create"
  
  get "/cars", to: "cars#index"
  get "/cars/:id", to: "cars#show"
end
