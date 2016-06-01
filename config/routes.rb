Rails.application.routes.draw do
  resources :users

  get 'welcome/index'
  get 'mail/send_mail'
  get 'mail/complete'
  
  root 'welcome#index'
end
