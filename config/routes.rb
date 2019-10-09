Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'
  get 'home_what_we_do', to: 'pages#home_what_we_do'
  get 'what_we_do', to: 'pages#what_we_do'
  get 'solutions/demos', to: 'solutions#demos'
  get 'solutions/org', to: 'solutions#org'
  get 'solutions/campaign', to: 'solutions#campaign'
  get 'solutions/soft', to: 'solutions#soft'

  resources :contacts

  post 'attachments', to: 'attachments#create'
end
