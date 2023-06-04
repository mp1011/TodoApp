Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  Rails.application.routes.draw do
    get '/helloworld/:x', to: 'hello_world#say'
  end

  Rails.application.routes.draw do
    get '/todoitem', to: 'todo_item#get'
  end

  Rails.application.routes.draw do
    get '/todoitem/:id/children', to: 'todo_item#get_children'
  end

  Rails.application.routes.draw do
    post '/todoitem', to: 'todo_item#post'
  end

  Rails.application.routes.draw do
    put '/todoitem/:id/changesort', to: 'todo_item#change_sort'
  end

  Rails.application.routes.draw do
    get '/todoitem/:id', to: 'todo_item#get_by_id'
  end

  Rails.application.routes.draw do
    put '/todoitem/:id', to: 'todo_item#update'
  end

  Rails.application.routes.draw do
    put '/todoitem/:id/setparent/:parent_id', to: 'todo_item#set_parent'
  end

  Rails.application.routes.draw do
    get '/user', to: 'user#current'
  end


  Rails.application.routes.draw do
    get '/auth/google_oauth2/callback', to: 'sessions#create'
  end

  Rails.application.routes.draw do
    get '/logout', to: 'sessions#log_out'
  end

  Rails.application.routes.draw do
    get '/login', to: 'sessions#log_in'
  end
  
end
