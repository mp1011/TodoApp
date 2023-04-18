require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'

class SaveTodoItem
    attr_reader :item

    def initialize(item)
        @item = item
    end 

    def handle()
        SaveTodoItemHandler.new.handle(self)
    end 

end

class SaveTodoItemHandler
    include $injector['data_context']

    def handle(request)
        data_context.save_todo_item(request.item)
    end
end