require_relative '../models/data_models/user'
require_relative '../features/get_user'

class AuthService 

    def get_current_user(session)

        session_user = session[:user_id]
        if session_user.nil?
            nil 
        else 
            GetUser.new(session_user).handle
        end 

    end 

    def get_current_user_id(session)
        user = get_current_user(session)
        if user.nil?
            0
        else 
            user.id 
        end 
    end 

    def check_login(session)
        get_current_user(session).present?
    end 

end 

class MockAuthService 

    def get_current_user(session)
        User.new(1,'System','System')
    end 

    def get_current_user_id(session)
        1
    end 

    def check_login(session)
        true
    end 

end 