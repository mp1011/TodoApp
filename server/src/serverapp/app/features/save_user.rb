require_relative '../helpers/di_container'
require_relative '../models/data_models/user'

class SaveUser
    attr_reader :name, :email

    def initialize(name, email)
        @name = name
        @email = email
    end 

    def handle
        SaveUserHandler.new.handle(self)
    end 

end

class SaveUserHandler
    include $injector['data_context']

    def handle(request)

        existing_user = data_context
            .users
            .where('email=?', request.email)
            .first 

        if existing_user.nil?
            saved_user = data_context.save_user(User.new(0, request.name, request.email))
            User.map_from(save_user)
        else 
            User.map_from(existing_user)
        end 

    end
end