Rails.application.routes.draw do
  root 'home#index'
  get 'search', to: 'home#search'

  devise_for :recruiters, controllers: { registrations: 'recruiters/registrations' }
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }
  
  resources :recruiters, only: [:index]
  resources :candidates, only: [:index]
  resources :companies, except: [:destroy]
  resources :jobs, except: [:destroy] do
    resources :job_applications, except: [:edit, :update] do
      resources :rejections, only: [:index, :new, :create] 
      resources :offers, only: [:show, :new, :create] do
        post 'accept', on: :member
        resources :denials, only: [:show, :new, :create]
      end
    end
    post 'disable', on: :member
    post 'enable', on: :member
  end
end
