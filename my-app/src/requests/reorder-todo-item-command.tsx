import TodoItem from '../models/todo-item';
import { Container, ContainerInstance, Service } from 'typedi';
import IRequestHandler from './request';
import ApiClient from '../services/api-client';

class ReorderTodoItemCommand {
    id: number;
    newOrder: number;

    constructor(id: number, newOrder:number) {
        this.id = id;
        this.newOrder = newOrder;
    }

    async handle() : Promise<TodoItem[]>
    {
        const handler = Container.get(ReorderTodoItemCommandHandler);
        return await handler.handle(this);
    }
}

@Service({ global: true })
class ReorderTodoItemCommandHandler implements IRequestHandler<ReorderTodoItemCommand, TodoItem[]>
{
    private readonly api_client:ApiClient;

    constructor(container:ContainerInstance ) {
        this.api_client = container.get(ApiClient);
    }

    async handle(request:ReorderTodoItemCommand) : Promise<TodoItem[]>
    {
        return await this.api_client.putJson(`/todoitem/${request.id}/changesort?new_sort_order=${request.newOrder}`);
    }
}


export { ReorderTodoItemCommand,ReorderTodoItemCommandHandler};