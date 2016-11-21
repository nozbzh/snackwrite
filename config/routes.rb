Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'pages#home'
  get 'coming-soon', to: 'pages#coming_soon'

  resources :users, path: 'my-profile', only: [:show, :edit, :update] do
  end

  resources :votes, only: [:index] do
  end

  resources :topics, only: [:index] do
    member do
      resources :contests, only: [:new] do
        collection do
          post :create, as: :create
        end
        member do
          post :create_post
        end
      end
    end
  end

  get "contest/:id" => "contests#continue_contest", as: :continue_contest

  resources :contests, only: [:index, :show] do
    member do
      resources :posts, only: [] do
        resources :votes, only: :create do
        end
      end
    end
  end

end
