Rails.application.routes.draw do
  root 'pages#home'
  get :what_we_do, to: 'pages#what_we_do'
  get 'solutions/demos', to: 'solutions#demos'
  get 'solutions/org', to: 'solutions#org'
  get 'solutions/campaign', to: 'solutions#campaign'
  get 'solutions/soft', to: 'solutions#soft'
end
