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
    get 'show_charts', on: :collection
    get 'send_status', on: :member 
    get 'select2_index', on: :collection
    get 'datatables_index', on: :collection
    resources :attachments, module: :projects, only: [:create]
    resources :point_files, module: :projects, except: [:index] do
      get 'download', on: :member
      get 'datatables_index_zs_point', on: :collection # Displays zs_points for showed point_file
      get 'datatables_index_ww_point', on: :collection # Displays ww_points for showed point_file
    end
    resources :proposal_files, module: :projects, except: [:index] do
      get 'download', on: :member
    end
  end

  resources :enrollments do
    resources :attachments, module: :enrollments, only: [:create]
  end

  resources :roles do
    get 'datatables_index', on: :collection
    get 'datatables_index_user', on: :collection # Displays roles for showed user
    resources :users, only: [:create, :destroy], controller: 'roles/users'
  end    

  resources :accessorizations do
    get 'datatables_index_user', on: :collection # Displays accessorizations for showed user
    get 'datatables_index_role', on: :collection # Displays accessorizations for showed role
    get 'datatables_index_errand', on: :collection # Displays accessorizations for showed role
  end    

  resources :events do
    get 'show_charts', on: :collection
    get 'send_status', on: :member 
    get 'datatables_index', on: :collection
    resources :attachments, module: :events, only: [:create]
    resources :comments, module: :events, only: [:create, :destroy]
    resources :ratings, module: :events, except: [:index] do
      get 'export', on: :member 
    end
  end

  resources :errands do
    get 'show_charts', on: :collection
    get 'select2_index', on: :collection
    get 'datatables_index', on: :collection
    resources :attachments, module: :errands, only: [:create]
  end

  resources :charts, only: [] do
    get 'errands_by_month', on: :collection
    get 'errands_by_month_status', on: :collection
    get 'errands_by_status', on: :collection
    get 'events_by_status_for_errand', on: :collection
    get 'events_by_status_for_user', on: :collection
    get 'events_by_status_type_for_user', on: :collection
    get 'events_by_type_status_for_user', on: :collection
    get 'events_by_month', on: :collection
    get 'events_by_month_status', on: :collection
    get 'events_by_status', on: :collection
    get 'events_by_type', on: :collection
    get 'events_by_type_for_status', on: :collection
    get 'events_by_month_type', on: :collection
    get 'point_files', on: :collection
    get 'xml_miejsce_realizacji_tables', on: :collection
  end

  resources :works, only: [:index] do
    post 'datatables_index', on: :collection # for User
    post 'datatables_index_trackable', on: :collection # for Trackable
    post 'datatables_index_user', on: :collection # for User
  end

  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'

  resources :attachments, only: [:show, :destroy]

  resources :zs_points
  resources :ww_points


end
