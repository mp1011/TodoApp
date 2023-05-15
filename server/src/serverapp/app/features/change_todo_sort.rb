class ChangeTodoSort
    attr_reader :item, :new_sort, :current_user 

    def initialize(item, new_sort, current_user)
        @item = item
        @new_sort = new_sort
        @current_user = current_user
    end 

    def handle()
        ChangeTodoSortHandler.new.handle(self)
    end 

end

class ChangeTodoSortHandler
    include $injector['data_context']

    def handle(request)

        item = data_context.todo_items
            .where("created_by = ? and id = ?", request.current_user, request.item.id)
            .first 

       
        items_to_reorder = data_context.todo_items
            .where("created_by = ? and sort_order >= ? and id <> ?", request.current_user, request.new_sort, request.item.id)
            .order("sort_order asc")
       
        ActiveRecord::Base.transaction do
            
            item.sort_order = request.new_sort
            item.save

            next_sort = request.new_sort + 1
            items_to_reorder.each do |x|
                x.sort_order = next_sort

                x.save
                next_sort += 1
            end 

        end 

        item 

    end
end