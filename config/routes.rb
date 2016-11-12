Rails.application.routes.draw do
  resources :todo_items
  post 'users/create' => 'users/create'
  post 'users/login' => 'users/login'
end
