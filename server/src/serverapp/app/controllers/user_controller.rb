class UserController < ApplicationController
    include $injector['auth_service']
    include AuthenticatedController

    protect_from_forgery with: :null_session
    before_action :before_request, except: [:new, :create]
    
    def current 
        render json: @current_user
    end 
end 