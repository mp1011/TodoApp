import TodoItem from '../models/todo-item';
import ApiClient from '../services/api-client';
import { Container, ContainerInstance, Service } from 'typedi';
import IRequestHandler from './request';

class SetTodoParentCommand {
    childId: number;
    parentId: number;

    constructor(childId: number, parentId:number ) {
        this.childId = childId;
        this.parentId = parentId;
    }

    async handle() : Promise<TodoItem>
    {
        const handler = Container.get(SetTodoParentCommandHandler);
        return await handler.handle(this);
    }
}

@Service({ global: true })
class SetTodoParentCommandHandler implements IRequestHandler<SetTodoParentCommand, TodoItem>
{
    private readonly apiClient:ApiClient;

    constructor(container:ContainerInstance ) {
        this.apiClient = container.get(ApiClient);
    }

    async handle(request:SetTodoParentCommand) : Promise<TodoItem>
    {
        return await this.apiClient
                         .putJson<TodoItem>(`/todoitem/${request.childId}/setparent/${request.parentId}`);
    }
}


export { SetTodoParentCommand,SetTodoParentCommandHandler};