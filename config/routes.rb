Rails.application.routes.draw do
  resources :lectures
  resources :question_set_junctions
  resources :question_sets
  resources :answers
  resources :questions
  resources :tags
  resources :registrations
  resources :courses
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
