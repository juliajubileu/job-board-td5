Rails.application.routes.draw do
  root 'home#index'

  devise_for :recruiters, controllers: { registrations: 'recruiter/registrations' }

  resources :companies, :jobs
end
