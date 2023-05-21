import TodoItem from '../models/todo-item';
import DataAccess from '../services/data-access';
import { Container, ContainerInstance, Service } from 'typedi';
import IRequestHandler from './request';

class AddTodoItemRequest {
    text: string;

    constructor(text: string ) {
        this.text = text;
    }

    async handle() : Promise<TodoItem>
    {
        const handler = Container.get(AddTodoItemRequestHandler);
        return await handler.handle(this);
    }
}

@Service({ global: true })
class AddTodoItemRequestHandler implements IRequestHandler<AddTodoItemRequest, TodoItem>
{
    private dataAccess : DataAccess;

    constructor(container:ContainerInstance ) {
        this.dataAccess = container.get(DataAccess);
    }

    async handle(request:AddTodoItemRequest) : Promise<TodoItem>
    {
        return await this.dataAccess
            .saveTodoItem(new TodoItem(0,request.text));
    }
}


export { AddTodoItemRequest,AddTodoItemRequestHandler};