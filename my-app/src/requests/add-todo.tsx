import TodoItem from '../models/todo-item';
import DataAccess from '../services/data-access';
import { Service, ContainerInstance } from 'typedi';
import IRequestHandler from './request';

class AddTodoRequest {
    text: string;

    constructor(text: string ) {
        this.text = text;
    }
}

@Service("AddTodoRequestHandler")
class AddTodoRequestHandler implements IRequestHandler<AddTodoRequest, TodoItem>
{
    private dataAccess : DataAccess;

    constructor(container : ContainerInstance) {
        this.dataAccess = container.get(DataAccess);
    }

    handle(request:AddTodoRequest) : TodoItem
    {
        return this.dataAccess
            .insertTodoItem(new TodoItem(request.text));
    }
}


export { AddTodoRequest,AddTodoRequestHandler};