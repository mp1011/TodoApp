require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../features/get_todo_items'
require_relative '../features/save_todo_item'
require_relative '../models/page_info'

class TodoItemController < ApplicationController    
    
    def get
        page_number = params[:pageNumber].to_i || 0
        page_size = params[:pageSize].to_i || 5
        search = params[:search]

        page_info = PageInfo.new(page_number, page_size)
        render json: GetTodoItems.new(search, page_info).handle
    end

    def post 
         todo_item = TodoItem.from_json(JSON.parse(request.body.read))
         SaveTodoItem.new(todo_item).handle
         render plain: todo_item.text
    end 

end
