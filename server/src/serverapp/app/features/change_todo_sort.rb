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
            .where(created_by: request.current_user.id, id: request.item.id)
            .first
       
        items_to_reorder = data_context.todo_items
            .where(created_by: request.current_user.id, parent_id: request.item.parent_id)
            .where("sort_order >= ? and id <> ?", request.new_sort, request.item.id)
            .order("sort_order asc")
        
        changed_items = []
        
        ActiveRecord::Base.transaction do
            
           
            changed_items << item 

            item.sort_order = request.new_sort
            item.save

            next_sort = request.new_sort + 1
            items_to_reorder.each do |x|

                if x.sort_order != next_sort
                    changed_items << x
                    x.sort_order = next_sort
                    x.save                
                end 

                next_sort += 1
            end 

        end 

        changed_items 

    end
end