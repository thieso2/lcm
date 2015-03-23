Rails.application.routes.draw do

  root to: 'visitors#index'
  
  devise_for :user
  
  resources :people
  
  resources :group_types
  resources :groups
  resources :events
  resources :teams
  
  resources :role_types
  resources :assignments
  
  resource :import_teilnehmer,   only: [:new, :create]
  resource :import_absolventen,  only: [:new, :create]
end
