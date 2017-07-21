Rails.application.routes.draw do
  root :to => redirect('/courses')

  resources :lectures
  resources :question_sets
  resources :answers
  resources :questions
  resources :registrations
  resources :courses
  resources :users
  resources :gradebooks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'livelecture/show', to: 'livelecture#show'
end
