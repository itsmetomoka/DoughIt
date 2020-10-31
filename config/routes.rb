Rails.application.routes.draw do
	devise_for :users,controllers:{
		registrations: 'devise/registrations',
		sessions: 'devise/sessions'
	}
	root 'lessons#about'
	get 'top' => 'lessons#top'

	get 'lessons/complete' => 'lessons#complete'
	get 'search' => 'searches#search'
	get 'users/check' => 'users#check'
	patch 'users/withdrawal' => 'users#withdrawal'

	resources :users, only: [:edit, :update, :show] do
		resources :reviews, only: [:create, :destroy, :index]
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

end
