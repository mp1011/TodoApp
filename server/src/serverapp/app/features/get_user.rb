require_relative '../helpers/di_container'
require_relative '../models/data_models/user'

class GetUser
    attr_reader :id

    def initialize(id)
        @id = id
    end 

    def handle
        GetUserHandler.new.handle(self)
    end 

end

class GetUserHandler
    include $injector['data_context']

    def handle(request)

        db_user = data_context
            .users
            .where('id=?', request.id)
            .first 

        if db_user.nil?
            nil 
        else 
            User.map_from(db_user)
        end 

    end
end