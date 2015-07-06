Rails.application.routes.draw do

  root to: 'visitors#index'

  devise_for :user

  resources :people

  #resources :group_types
  #resources :groups

  resources :event_role_types
  resources :event_types
  resources :events

  resources :team_role_types
  resources :team_types
  resources :teams

  resources :locations

  resources :assignments
  resources :calls

  resource :import_teilnehmer,   only: [:new, :create]
  resource :import_absolventen,  only: [:new, :create]
end
