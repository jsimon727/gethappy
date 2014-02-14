GetHappyApp::Application.routes.draw do

resources :users do
  resources :locations do
  resources :bars
  resources :deals, except: [:edit, :new]
  end
end

get "/login", to: "session#new"
post "/session", to: "session#create"
delete "/logout", to: "session#destroy"

root "welcome#index"

end
