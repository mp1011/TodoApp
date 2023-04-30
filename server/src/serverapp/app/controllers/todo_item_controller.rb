require_relative '../helpers/di_container'
require_relative '../models/data_models/todo_item'
require_relative '../features/get_todo_items'
require_relative '../features/save_todo_item'
require_relative '../models/page_info'
require_relative '../services/auth_service'
require_relative './concerns/controller_auth'

class TodoItemController < ApplicationController
    include $injector['auth_service']
    include ControllerAuth

    protect_from_forgery with: :null_session
    before_action :before_request, except: [:new, :create]

    def get
        page_info = PageInfo.from_request(params) 
        render json: GetTodoItems.new(params[:search], page_info, session).handle
    end

    def post
         todo_item = TodoItem.from_json(JSON.parse(request.body.read))
         todo_item = SaveTodoItem.new(todo_item, session).handle
         render json: todo_item
    end 

end
