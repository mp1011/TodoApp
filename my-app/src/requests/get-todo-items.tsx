import TodoItem from '../models/todo-item';
import DataAccess from '../services/data-access';
import { Container, Service, ContainerInstance } from 'typedi';
import IRequestHandler from './request';

class GetTodoItemsRequest {
    searchText?: string;

    constructor(searchText?: string ) {
        this.searchText = searchText;
    }

    async handle() : Promise<TodoItem[]>
    {
        const handler = Container.get(GetTodoItemsRequestHandler);
        return await handler.handle(this);
    }
}

@Service()
class GetTodoItemsRequestHandler implements IRequestHandler<GetTodoItemsRequest,TodoItem[]>
{
    private dataAccess : DataAccess;

    constructor(container:ContainerInstance ) {
        this.dataAccess = container.get(DataAccess);
    }

    async handle(request:GetTodoItemsRequest) : Promise<TodoItem[]>
    {
        return await this.dataAccess.getTodoItems(request.searchText);
    }
}


export { GetTodoItemsRequest,GetTodoItemsRequestHandler};