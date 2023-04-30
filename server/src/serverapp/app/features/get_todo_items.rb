require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../models/paged_result'
require_relative '../services/auth_service'
class GetTodoItems

    attr_reader :search_text, :page_info, :session

    def initialize(search_text, page_info, session)
        @search_text = search_text
        @page_info = page_info
        @session = session 
    end 

    def handle
        GetTodoItemsHandler.new.handle(self)
    end

end

class GetTodoItemsHandler
    include $injector['data_context']
    include $injector['auth_service']

    def handle(request)

        query = data_context
            .todo_items
            .where('created_by = ?', auth_service.get_current_user_id(request.session))

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