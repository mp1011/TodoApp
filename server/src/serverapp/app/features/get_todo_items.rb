require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../models/paged_result'
require_relative '../services/auth_service'

class GetTodoItems
    attr_reader :search_text, :page_info, :current_user

    def initialize(search_text, page_info, current_user)
        @search_text = search_text
        @page_info = page_info
        @current_user = current_user 
    end 

    def handle
        GetTodoItemsHandler.new.handle(self)
    end

end

class GetTodoItemsHandler
    include $injector['data_context']

    def handle(request)

        query = data_context
            .todo_items
            .where('created_by = ?', request.current_user.id)

        if !request.search_text.nil? && !request.search_text.empty?
            query = query.where('text like ?', "%#{request.search_text}%")
        end

        total_items = query.count

        paged_query = query
           .get_page(request.page_info)
           .map { |x| TodoItem.map_from(x)}

        PagedResult.new(paged_query, request.page_info, total_items)
    end
end