Rails.application.routes.draw do
  LOCALES = /en|pt\-BR/

  root 'home#index'
  get '/:locale' => 'home#index', locale: LOCALES

  scope "(:locale)", local: LOCALES do
  	resources :rooms do
  		resources :reviews, only: [:create, :update], module: :rooms
  	end
  	resources :users
  end

  resource :confirmation, only: [:show]
  resource :user_sessions, only: [:create, :new, :destroy]
end
