Rails.application.routes.draw do
  devise_for :recruiters
  root 'home#index'
end
