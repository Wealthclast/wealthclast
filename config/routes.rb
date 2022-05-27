Rails.application.routes.draw do
  root "pages#index"

  get "login", to: "authorization#new", as: "login"
  get "/auth/pathofexile/callback", to: "authorization#callback", as: "oauth_callback"
  get "dashboard", to: "pages#dashboard", as: "dashboard"
end
