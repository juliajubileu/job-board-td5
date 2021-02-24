Rails.application.routes.draw do
  root 'home#index'
  get 'search', to: 'home#search'

  devise_for :recruiters, controllers: { registrations: 'recruiters/registrations' }
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }
  
  resources :recruiters, only: %i[index]
  resources :candidates, only: %i[index]
  resources :companies
  resources :jobs do
    resources :applications, shallow: true
    post 'disable', on: :member
    post 'enable', on: :member
  end
end
