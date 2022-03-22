Rails.application.routes.draw do
  root 'pages#home'

  resources :patients
  resources :visit_notes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '*path', to: 'pages#home', via: :all
end
