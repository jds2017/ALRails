Rails.application.routes.draw do
  resources :responses
  resources :question_to_tag_junctions
  resources :course_to_lecture_junctions
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

  get 'livelecture/show', to: 'livelecture#show'
end
