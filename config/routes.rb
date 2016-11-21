Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'pages#home'

  resources :users, path: 'my-profile', only: [:show, :edit, :update] do
  end

  resources :topics, only: [:index] do
    #get "choose-your-word" => "topics#choose_word", as: :word
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
