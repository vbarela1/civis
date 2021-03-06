Rails.application.routes.draw do
  root 'home#index'

  # DEVISE ROUTES
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # API ROUTES
  namespace :api do
    get 'logged_in_user', to: 'users#logged_in_user'
    get 'user', to: 'users#show'
    get 'reps', to: 'reps#index'

    put 'user', to: 'users#update'
    put 'ties/:id', to: 'ties#update'

    delete 'user/:id', to: 'users#destroy'
  end

  # NO ROUTES BELOW THIS LINE -- React Router
  get '*unmatched_route', to: 'home#index'
end
