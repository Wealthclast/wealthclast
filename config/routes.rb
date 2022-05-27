Rails.application.routes.draw do
  root "pages#index"

  get "login", to: "authorization#new", as: "login"
  get "dashboard", to: "pages#dashboard", as: "dashboard"
end
