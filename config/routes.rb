Rails.application.routes.draw do
	devise_for :users
	root 'lessons#about'
	get 'top' => 'lessons#top'
	get 'user_page' => 'users#show'
	patch 'user/withdrawal' => 'users#withdrawal'
	get 'lessons/complete' => 'lessons#complete'
	get 'searches/search' => 'searches#search'

	resources :users, only: [:edit, :update]

	resources :lessons, only: [:index, :show, :new, :create] do
		resources :favorites, only: [:create, :destroy, :index]
		resources :comments, only: [:create, :destroy]
		resources :reservations, only: [:create, :index]
	end

end
