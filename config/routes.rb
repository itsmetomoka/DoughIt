Rails.application.routes.draw do
	devise_for :users,controllers:{
		registrations: 'devise/registrations',
		sessions: 'devise/sessions'
	}
	root 'lessons#about'
	get 'top' => 'lessons#top'
	get 'lessons/history' => 'lessons#history'
	get 'lessons/complete' => 'lessons#complete'
	get 'search' => 'searches#search'
	get 'users/check' => 'users#check'
	patch 'users/withdrawal' => 'users#withdrawal'
	devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end


	resources :users, only: [:edit, :update, :show] do
		resources :reviews, only: [:create, :destroy, :index]
		get 'favorite' => 'favorites#index'
	end


	resources :lessons, only: [:index, :show, :new, :create] do
		collection do
			post :new, path: :new, as: :new, action: :back
			post 'confirm' => 'lessons#confirm'
		end
		resource :favorites, only: [:create, :destroy, :index]
		resources :comments, only: [:create, :destroy]
		resources :reservations, only: [:create, :index]
	end
	
	resources :notifications, only: :index
	delete 'notification' => 'notifications#destroy_all'
end
