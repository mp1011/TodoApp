class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']
        user = SaveUser.new(auth.info.name, auth.info.email).handle
        session[:user_id] = user.id
        session[:id_token] = auth.extra.id_token 
       
        redirect_to session[:return_to].set_query_value 'token', auth.extra.id_token 
    end

    def log_in
        token = session[:id_token]
        
        token = 'test123abc' if params[:isTest]

        if token.present?
            redirect = params[:return] || session[:return_to];
            redirect = "/" if redirect.include?("login")
            redirect = redirect.set_query_value 'token', token 
            redirect_to redirect
        else 
            session[:return_to] = params[:return] || request.original_url
            redirect_to '/auth/google_oauth2'
        end 

    end 

    def log_out 
        session[:user_id] = nil
        session[:id_token] = nil 
        redirect_to params[:return] || ""
    end 
end