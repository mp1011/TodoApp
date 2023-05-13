
class AuthService 

    def get_current_user(request)
        auth_header = request.headers['Authorization']
        get_user_from_header(auth_header) || get_user_from_session(request.session)
    end 

    def get_user_from_session(session)

        session_user = session[:user_id]
        if session_user.nil?
            nil 
        else 
            GetUser.new(id: session_user).handle
        end 

    end 

    def get_user_from_header(auth_header)

        type, token = auth_header.split " " unless auth_header.nil? 

        return nil if token.nil? || token.nil? || type != "Bearer"

        unless Rails.env.production? 
            return User.new(id:1, name:'System', email:'System') if token == 'test123abc'
        end 

        begin    
            client_id = ENV['GOOGLE_CLIENT_ID']
            key_source = Google::Auth::IDTokens::JwkHttpKeySource.new(ENV['GOOGLE_KEY_SOURCE'])          
            unverified_token = JWT.decode token, nil, false

            options = { algorithms: unverified_token[1]["alg"]}
            
            validator = Google::Auth::IDTokens::Verifier.new(key_source: key_source, aud: client_id, azp: client_id, iss: "https://accounts.google.com")
            payload = validator.verify(token)
            GetUser.new(email: payload["email"]).handle
        rescue => e
            puts e
            return nil 
        end
    end 

end 

class MockAuthService 
    def get_current_user(request)
        User.new(id:1, name:'System', email:'System')
    end 

    def get_user_from_session(session)
        User.new(id:1, name:'System', email:'System')
    end 

    def get_user_from_header(auth_header)
        User.new(id:1, name:'System', email:'System')
    end 
end 