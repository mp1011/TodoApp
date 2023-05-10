require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../services/auth_service'

class SaveTodoItem
    attr_reader :item, :current_user 

    def initialize(item, current_user)
        @item = item
        @current_user = current_user
    end 

    def handle()
        SaveTodoItemHandler.new.handle(self)
    end 

end

class SaveTodoItemHandler
    include $injector['data_context']

    def handle(request)
        data_context.save_todo_item(request.item, request.current_user.id)
    end
end