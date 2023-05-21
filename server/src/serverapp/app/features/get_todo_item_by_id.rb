class GetTodoItemById
    attr_reader :id, :current_user

    def initialize(id, current_user)
        @id = id
        @current_user = current_user 
    end 

    def handle
        GetTodoItemByIdHandler.new.handle(self)
    end

end

class GetTodoItemByIdHandler
    def handle(request)
        item = TodoItem.find(request.id);

        raise "Record not found" if item.nil?
        raise "This record belongs to another user" if item.created_by != request.current_user.id

        item         
    end
end