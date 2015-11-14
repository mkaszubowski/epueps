Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'static_pages#home'

  resources :subjects, only: [:index, :show] do
    get 'info'
    resources :lessons, only: [:index]
  end
  resources :articles, only: [:new, :create, :show, :index]
  resources :contact_emails, only: [:create]
  resources :profile_videos, only: [:create]

  get '/contact', to: 'contact_emails#new'
  get '/about', to: 'static_pages#about'

  namespace :admin do
    resources :users

    resources :subjects do
      get 'deleted', to: 'subjects#trash', on: :collection
      get 'publish', to: 'subjects#publish', on: :member

      resources :lessons, except: [:index] do
        get 'sort', to: 'lessons#sort', on: :member
        resources :videos, except: [:show, :index]
      end
    end

    resources :articles, except: [:show]

    match '/', to: 'admin_pages#home', via: :get
  end


end
