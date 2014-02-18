GetHappyApp::Application.routes.draw do

resources :users do
  resources :deals
  resources :locations do
  resources :bars
  resources :deals, except: [:edit, :new, :show]
  end
end

get "/users/:user_id/customdeals", to: "deals#show"

get "/login", to: "session#new"
post "/session", to: "session#create"
delete "/logout", to: "session#destroy"

root "welcome#index"

end
