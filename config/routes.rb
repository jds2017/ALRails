Rails.application.routes.draw do
  resources :questions
  resources :tags
  resources :registrations
  resources :courses
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
