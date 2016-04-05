Rails.application.routes.draw do
  get "/:username", to: "users#show"
  get "/auth/github", as: "github_login"
  get "/auth/github/callback", to: "sessions#create"
  get "/", to: "users#show", as: "root"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
