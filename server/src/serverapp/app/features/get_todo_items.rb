class GetTodoItems
    attr_reader :search_text, :page_info, :current_user, :parent_id

    def initialize(search_text, page_info, current_user, parent_id=nil)
        @search_text = search_text
        @page_info = page_info
        @current_user = current_user
        @parent_id = parent_id 
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
            .where(created_by: request.current_user.id, parent_id: request.parent_id)

        if !request.search_text.nil? && !request.search_text.empty?
            query = query.where('text like ?', "%#{request.search_text}%")
        end

        query = query.order("sort_order asc")
        
        total_items = query.count

        paged_query = query
           .get_page(request.page_info)

        PagedResult.new(paged_query, request.page_info, total_items)
    end
end