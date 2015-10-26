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

  resources :person_event_assignments
  resources :person_team_assignments

  resources :calls

  resources :import_jobs,         only: [:index, :show, :destroy]

  resource :import_teilnehmer,   only: [:new, :create]
  resource :import_absolventen,  only: [:new, :create]

  resources :report, only: [:index, :show]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
