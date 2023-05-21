class UpdateTodoItem
    attr_reader :id, :properties, :current_user 

    def initialize(id, properties, current_user)
        @id = id
        @properties = properties
        @current_user = current_user
    end 

    def handle()
        UpdateTodoItemHandler.new.handle(self)
    end 

end

class UpdateTodoItemHandler
    include $injector['data_context']

    def handle(request)
        data_context.update_record(TodoItem, request.id, request.properties, request.current_user.id)
    end
end