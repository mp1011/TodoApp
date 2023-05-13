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

        existing_user || data_context.save_user(User.new(0, request.name, request.email))            
    end
end