Rails.application.routes.draw do
  get "/auth/github", as: "github_login"
  get "/auth/github/callback", to: "sessions#create"
  get "/", to: "users#show", as: "root"
  delete "/logout", to: "sessions#destroy", as: "logout"
  get "/:username", to: "users#show"
end
