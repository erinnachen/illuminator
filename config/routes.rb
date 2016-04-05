Rails.application.routes.draw do
  root to: "dashboard#show"
  get "/auth/github", as: "github_login"
  get "/auth/github/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
  get "/:username", to: "users#show"
end
