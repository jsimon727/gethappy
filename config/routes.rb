GetHappyApp::Application.routes.draw do

resources :users do
  resources :deals, except: [:index, :edit, :new, :create, :update]
  resources :bars, except: [:delete]
  resources :locations do
    resources :deals, except: [:edit, :new, :show, :create, :update]
  end
end

# post "/users/:user_id/bars/favorite", to: "bars#favorite", as: "favorite"
# post "/users/:user_id/unfavorite", to: "bars#unfavorite", as: "unfavorite"

get "/users/:user_id/customdeals", to: "deals#show"

# get "/users/:user_id/bars", to: "bars#index", as: "bars"

resources :favorite_bars, only: [:destroy]

get "/login", to: "session#new"
post "/session", to: "session#create"
delete "/logout", to: "session#destroy"

root "welcome#index"

end
