Rails.application.routes.draw do
  root 'pages#home'
  get :what_we_do, to: 'pages#what_we_do'
end
