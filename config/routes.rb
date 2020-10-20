Rails.application.routes.draw do
  get 'favorites/index'
  get 'lessons/top'
  get 'lessons/about'
  get 'lessons/index'
  get 'lessons/show'
  get 'lessons/create'
  get 'lessons/complete'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
