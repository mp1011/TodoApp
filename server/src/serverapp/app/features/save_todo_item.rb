require_relative '../helpers/di_container.rb'
require_relative '../domain/models/todoitem'

class SaveTodoItem

    attr_reader :item 

    def initialize(item)
        @item = item
    end 

    def handle()
        SaveTodoItemHandler.new().handle(self)
    end 

end

class SaveTodoItemHandler
    include $injector["dataContext"]

    def handle(request)

        dataContext.saveTodoItem(request.item)
                
    end 

end