require_relative '../helpers/di_container.rb'
require_relative '../domain/models/todoitem'

class GetTodoItems

    attr_reader :searchText 
    attr_reader :pageInfo 

    def initialize(searchText, pageInfo)
        @searchText = searchText
        @pageInfo = pageInfo
    end 

    def handle()
        GetTodoItemsHandler.new().handle(self)
    end 

end

class GetTodoItemsHandler
    include $injector["dataContext"]


    def handle(request)

        query = dataContext.todoItems

        if(!request.searchText.nil? && !request.searchText.empty?)
            query = query.where("text like ?", "%#{request.searchText}%")
        end 

        query
           .get_page(request.pageInfo) 
           .map { |x| TodoItem.mapFrom(x)}     

    end 

end