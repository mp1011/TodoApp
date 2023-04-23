class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']
        # Use the authentication information to create or find a user in your app's database
        # Then log the user in and redirect them to the appropriate page
        session[:user_id] = 'abc'
        redirect_to root_path
        
    end
end