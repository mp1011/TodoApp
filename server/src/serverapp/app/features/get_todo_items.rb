require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../models/paged_result'

class GetTodoItems

    attr_reader :search_text, :page_info

    def initialize(search_text, page_info)
        @search_text = search_text
        @page_info = page_info
    end 

    def handle
        GetTodoItemsHandler.new.handle(self)
    end

end

class GetTodoItemsHandler
    include $injector['data_context']

    def handle(request)

        query = data_context.todo_items

        if !request.search_text.nil? && !request.search_text.empty?
            query = query.where('text like ?', "%#{request.search_text}%")
        end

        paged_query = query
           .get_page(request.page_info)
           .map { |x| TodoItem.map_from(x)}

        total_items = query.count

        PagedResult.new(paged_query, request.page_info, total_items)
    end
end