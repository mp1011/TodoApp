require_relative '../../services/auth_service'
require_relative '../../helpers/di_container'

module ControllerAuth
    
    def before_request
        
        if not auth_service.check_login(session)        
            session[:return_to] = request.original_url
            redirect_to '/auth/google_oauth2'
        end 
    end 

end 