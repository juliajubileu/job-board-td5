Rails.application.routes.draw do
  root 'home#index'

  devise_for :recruiters, controllers: { registrations: "registrations" }

  resources :companies
end
