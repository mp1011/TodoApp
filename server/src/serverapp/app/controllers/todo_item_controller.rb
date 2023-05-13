class TodoItemController < ApplicationController
    include $injector['auth_service']
    include AuthenticatedController

    protect_from_forgery with: :null_session
    before_action :before_request, except: [:new, :create]

    def get
        page_info = PageInfo.from_request(params) 
        render json: GetTodoItems.new(params[:search], page_info, @current_user).handle
    end

    def post
         todo_item = TodoItem.from_json(JSON.parse(request.body.read))
         todo_item = SaveTodoItem.new(todo_item, @current_user).handle
         render json: todo_item
    end 

end
