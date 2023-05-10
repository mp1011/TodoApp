require_relative '../helpers/di_container'
require_relative '../models/data_models/user'
require_relative '../features/save_user'

class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']
        user = SaveUser.new(auth.info.name, auth.info.email).handle
        session[:user_id] = user.id
        session[:id_token] = auth.extra.id_token 
        redirect_to session[:return_to]      
    end

    def log_in
        token = session[:id_token]
        
        if token.present?
            response.headers['Token'] = token 
            redirect_to ''
        else 
            session[:return_to] = request.original_url
            redirect_to '/auth/google_oauth2'
        end 

    end 

    def log_out 
        session[:user_id] = nil
        session[:id_token] = nil 
        redirect_to ""
    end 
end