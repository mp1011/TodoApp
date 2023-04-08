Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "helloworld#index"

  Rails.application.routes.draw do
    get '/helloworld/:x', to: 'hello_world#say'
  end

end