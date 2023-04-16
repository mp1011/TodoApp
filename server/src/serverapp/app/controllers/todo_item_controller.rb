require_relative '../helpers/di_container.rb'
require_relative '../domain/models/todoitem'

class TodoItemController < ApplicationController    
    include $injector["dataContext"]

    def get   
        page_number = params[:pageNumber].to_i || 0;
        page_size = params[:pageSize].to_i || 5;
        search = params[:search]

        if(page_size == 0)
          page_size = 5
        end 
          
        #todo, put this logic in a query
        render json: dataContext
          .todoItems
          .where("text like ?", "%#{search}%")
          .get_page(page_number, page_size) 
          .map { |x| TodoItem.mapFrom(x)}     
    end

    def post 

         todo_item = TodoItem.fromJson(JSON.parse(request.body.read))
         render plain: todo_item.text
    end 

end
