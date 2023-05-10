require_relative '../../services/auth_service'
require_relative '../../helpers/di_container'

module AuthenticatedController 
    
    attr_reader :current_user;

    def before_request     

        @current_user = auth_service.get_current_user request 

        render plain: "Login required", status: :forbidden if @current_user.nil?          
            #session[:return_to] = request.original_url
            #redirect_to '/auth/google_oauth2'
    end 

end 