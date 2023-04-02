import TodoItem from '../models/todo-item';
import DataAccess from '../services/data-access';
import { Service, ContainerInstance } from 'typedi';
import IRequestHandler from './request';

class GetTodoItemsRequest {

}

@Service("GetTodoItemsRequestHandler")
class GetTodoItemsRequestHandler implements IRequestHandler<GetTodoItemsRequest,TodoItem[]>
{
    private dataAccess : DataAccess;

    constructor(container:ContainerInstance ) {
        this.dataAccess = container.get(DataAccess);
    }

    handle(request:GetTodoItemsRequest) : TodoItem[]
    {
        return this.dataAccess.getTodoItems();
    }
}


export { GetTodoItemsRequest,GetTodoItemsRequestHandler};