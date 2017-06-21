Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :projects do
    get 'select2_index', on: :collection
  end
  resources :roles

  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
