require_relative '../helpers/di_container.rb'

class TodoItemController < ApplicationController    
    include $injector["dataContext"]

    def get   
        @pageNumber = params[:pageNumber].to_i || 0;
        @pageSize = params[:pageSize].to_i || 5;

        if(@pageSize == 0)
          @pageSize=5
        end 
           
        render json: dataContext.todoItems.get_page(@pageNumber,@pageSize)      
    end

end
