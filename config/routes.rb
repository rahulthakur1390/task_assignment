Rails.application.routes.draw do
  post 'api/register', to: 'auth#register'
  post 'api/login', to: 'auth#login'
  namespace :api do
    resources :tasks, only: [:create] do
      member do
        post 'assign', to: 'tasks#assign'
        patch 'complete', to: 'tasks#complete'
      end
      collection do
        get 'assigned', to: 'tasks#assigned'
      end
    end
  end
end

