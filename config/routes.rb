Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'
  get 'home_what_we_do', to: 'pages#home_what_we_do'
  get 'what_we_do', to: 'pages#what_we_do'
  get 'marketing', to: 'pages#marketing'
  get 'privacy', to: 'pages#privacy'
  get 'privacy_revisions/v1', to: 'pages#privacy_revisions_v1', as: :privacy_revisions_v1
  Solution::DICTIONARY.each do |solution_slug,_|
    get "solutions/#{solution_slug}", to: "solutions##{solution_slug}", as: :"solutions_#{solution_slug}"
  end
  get 'solutions/soft', to: 'solutions#soft', as: :solutions_soft
  post 'reports/subscribe', to: 'pages#subscribe_reports', as: :subscribe_reports

  resources :contacts
  resources :posts, only: :show

  post 'attachments', to: 'attachments#create'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development? || Rails.env.staging?
end
