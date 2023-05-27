class SetTodoParent
    attr_reader :item, :parent, :current_user 

    def initialize(item, parent, current_user)
        @item = item
        @parent = parent;
        @current_user = current_user
    end 

    def handle()
        SetTodoParentHandler.new.handle(self)
    end 

end

class SetTodoParentHandler
    include $injector['data_context']

    def handle(request)

        ActiveRecord::Base.transaction do

            last_parent = request.item.parent_id

            siblings = TodoItem
                        .where(created_by: request.current_user.id, parent_id: request.parent.id)
                        .order(sort_order: :desc)

            next_sort = if siblings.empty?
                            1
                        else 
                            siblings.first.sort_order + 1
                        end 

            data_context.update_record TodoItem, request.item.id, { sort_order: next_sort, parent_id: request.parent.id}, request.current_user.id

            need_reorder = TodoItem
                            .where(created_by: request.current_user.id, parent_id: last_parent)
                            .order(sort_order: :asc)
                            .to_a

            order = 1
            need_reorder.each do |x|
                x.sort_order = order
                order += 1
                x.save
            end

        end 

    end
end