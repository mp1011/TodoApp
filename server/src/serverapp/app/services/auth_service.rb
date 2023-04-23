require_relative '../models/data_models/user'

class AuthService 

    attr_reader :logged_in_user

    def initialize
        @logged_in_user = User.new(1, 'system', 'system')
    end

end 
