Rails.application.routes.draw do

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resources :users do
    get 'select2_index', on: :collection
    get 'datatables_index', on: :collection
    get 'datatables_index_role', on: :collection # Displays users for showed role
    patch 'account_off', on: :member
    patch 'account_on', on: :member
    resources :attachments, module: :users, only: [:create]
  end
  
  resources :customers do
    get 'select2_index', on: :collection
    get 'datatables_index', on: :collection
  end

  resources :projects do
    get 'send_status', on: :member 
    get 'select2_index', on: :collection
    get 'datatables_index', on: :collection
    resources :attachments, module: :projects, only: [:create]
    resources :point_files, module: :projects, except: [:index] do
      get 'download', on: :member
      get 'datatables_index_zs_point', on: :collection # Displays zs_points for showed point_file
      get 'datatables_index_ww_point', on: :collection # Displays ww_points for showed point_file
    end
    resources :opinions, module: :projects, except: [:index]
  end

  resources :roles do
    get 'datatables_index', on: :collection
    get 'datatables_index_user', on: :collection # Displays roles for showed user
    resources :users, only: [:create, :destroy], controller: 'roles/users'
  end    

  resources :accessorizations do
    get 'datatables_index_user', on: :collection # Displays accessorizations for showed user
    get 'datatables_index_role', on: :collection # Displays accessorizations for showed role
  end    

  resources :events do
    get 'send_status', on: :member 
    get 'datatables_index', on: :collection
    resources :comments, module: :events, only: [:create, :destroy]
  end



  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'

  resources :attachments, only: [:show, :destroy]

  resources :zs_points
  resources :ww_points


end
