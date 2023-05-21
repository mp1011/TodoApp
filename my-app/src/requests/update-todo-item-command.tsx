import TodoItem from '../models/todo-item';
import { Container, ContainerInstance, Service } from 'typedi';
import IRequestHandler from './request';
import ApiClient from '../services/api-client';

class UpdateTodoItemCommand {
    id: number;
    changes: any;

    constructor(id: number, changes:any) {
        this.id = id;
        this.changes=changes;
    }

    async handle() : Promise<TodoItem>
    {
        const handler = Container.get(UpdateTodoItemCommandHandler);
        return await handler.handle(this);
    }
}

@Service({ global: true })
class UpdateTodoItemCommandHandler implements IRequestHandler<UpdateTodoItemCommand, TodoItem>
{
    private readonly api_client:ApiClient;

    constructor(container:ContainerInstance ) {
        this.api_client = container.get(ApiClient);
    }

    async handle(request:UpdateTodoItemCommand) : Promise<TodoItem>
    {
        return await this.api_client.putJsonWithBody(`/todoitem/${request.id}`, request.changes);
    }
}


export { UpdateTodoItemCommand,UpdateTodoItemCommandHandler};