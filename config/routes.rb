Rails.application.routes.draw do
	devise_for :users,controllers:{
		registrations: 'devise/registrations',
		sessions: 'devise/sessions'
	}
	root 'lessons#about'
	get 'top' => 'lessons#top'
	get 'lessons/complete' => 'lessons#complete'
	get 'searches/search' => 'searches#search'

	resources :users, only: [:edit, :update, :show]
	resources :users do
      collection do
        get 'check'
        patch 'withdrawal'
      end
    end

	resources :lessons, only: [:index, :show, :new, :create] do
		resources :favorites, only: [:create, :destroy, :index]
		resources :comments, only: [:create, :destroy]
		resources :reservations, only: [:create, :index]
	end

end
