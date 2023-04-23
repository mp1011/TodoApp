import TodoItem from '../models/todo-item';
import DataAccess from '../services/data-access';
import { Service } from 'typedi';
import IRequestHandler from './request';

class AddTodoItemRequest {
    text: string;

    constructor(text: string ) {
        this.text = text;
    }
}

@Service("AddTodoItemRequestHandler")
class AddTodoItemRequestHandler implements IRequestHandler<AddTodoItemRequest, TodoItem>
{
    private dataAccess : DataAccess;

    constructor(dataAccess:DataAccess) {
        this.dataAccess = dataAccess;
    }

    async handle(request:AddTodoItemRequest) : Promise<TodoItem>
    {
        return await this.dataAccess
            .saveTodoItem(new TodoItem(request.text));
    }
}


export { AddTodoItemRequest,AddTodoItemRequestHandler};