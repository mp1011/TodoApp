require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../services/auth_service'

class SaveTodoItem
    attr_reader :item, :session 

    def initialize(item, session)
        @item = item
        @session = session
    end 

    def handle()
        SaveTodoItemHandler.new.handle(self)
    end 

end

class SaveTodoItemHandler
    include $injector['data_context']
    include $injector['auth_service']

    def handle(request)
        data_context.save_todo_item(request.item, auth_service.get_current_user_id(request.session))
    end
end