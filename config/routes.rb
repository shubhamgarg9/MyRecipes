Rails.application.routes.draw do

	root 'pages#home'

  get '/home' => 'pages#home'

  resources :recipes
end