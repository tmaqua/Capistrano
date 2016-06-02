Rails.application.routes.draw do

  resources :users

  get 'welcome/index'
  get 'mail/send_mail'
  get 'mail/complete'
  get 'notification/send_push'
  get 'notification/complete'
  
  root 'welcome#index'
end
