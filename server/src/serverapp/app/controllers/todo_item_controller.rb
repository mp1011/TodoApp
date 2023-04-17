require_relative '../helpers/di_container.rb'
require_relative '../domain/models/todoitem'
require_relative '../features/get_todo_items'
require_relative '../features/save_todo_item'
require_relative '../domain/models/PageInfo'

class TodoItemController < ApplicationController    
    
    def get   
        page_number = params[:pageNumber].to_i || 0;
        page_size = params[:pageSize].to_i || 5;
        search = params[:search]

        pageInfo = PageInfo.new(page_number, page_size)
        render json: GetTodoItems.new(search, pageInfo).handle()           
    end

    def post 

         todo_item = TodoItem.fromJson(JSON.parse(request.body.read))
         SaveTodoItem.new(todo_item).handle()
         render plain: todo_item.text
    end 

end
