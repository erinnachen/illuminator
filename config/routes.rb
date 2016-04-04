Rails.application.routes.draw do
  get "/:username", to: "users#show"
  get "/auth/github", as: "github_login"
  get "/auth/github/callback", to: "sessions#create"
end
