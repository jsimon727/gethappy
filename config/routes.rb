GetHappyApp::Application.routes.draw do

resources :users do
  resources :deals, except: [:index, :edit, :new, :create, :update]
  resources :locations do
  resources :deals, except: [:edit, :new, :show, :create, :update]
  end
end

get "/users/:user_id/customdeals", to: "deals#show"

get "/login", to: "session#new"
post "/session", to: "session#create"
delete "/logout", to: "session#destroy"

root "welcome#index"

end
