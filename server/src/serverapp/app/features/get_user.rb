class GetUser
    attr_reader :id, :email 

    def initialize(id:0, email:'')
        @id = id
        @email=email
    end 

    def handle
        GetUserHandler.new.handle(self)
    end 

end

class GetUserHandler
    include $injector['data_context']

    def handle(request)

        if request.email.present?
            db_user = data_context
                .users
                .where('email=?', request.email)
                .first
        else 
            db_user = data_context
                .users
                .where('id=?', request.id)
                .first
        end 

        if db_user.nil?
            nil 
        else 
            db_user
        end 

    end
end