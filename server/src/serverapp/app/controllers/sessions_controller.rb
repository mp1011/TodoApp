require_relative '../helpers/di_container'
require_relative '../models/data_models/user'
require_relative '../features/save_user'

class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']

        user = SaveUser.new(auth.info.name, auth.info.email).handle

        session[:user_id] = user.id
        redirect_to session[:return_to]        
    end
end