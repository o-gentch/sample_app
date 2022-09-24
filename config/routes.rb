Rails.application.routes.draw do

  resources :users

  root 'static_pages#home' 
  get  'sessions/new'

  get  'help'      => 'static_pages#help'
  get  'about'     => 'static_pages#about'
  get  'contact'   => 'static_pages#contact'
  get  'signup'    => 'users#new'
  get  'login'     => 'sessions#new'
  post 'login'     => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  
end
