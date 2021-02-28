Rails.application.routes.draw do
  root 'home#index'
  get 'search', to: 'home#search'

  devise_for :recruiters, controllers: { registrations: 'recruiters/registrations' }
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }
  
  resources :recruiters, only: %i[index]
  resources :candidates, only: %i[index]
  resources :companies
  resources :jobs do
    shallow do
      resources :applications do
        resources :rejections
        resources :offers do
          post 'accept', on: :member
          resources :denials
        end
      end
    end
    post 'disable', on: :member
    post 'enable', on: :member
  end
end
