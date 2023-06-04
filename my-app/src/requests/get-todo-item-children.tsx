import TodoItem from '../models/todo-item';
import ApiClient from '../services/api-client';
import { Container, Service, ContainerInstance } from 'typedi';
import IRequestHandler from './request';
import PageInfo from '../models/page-info';
import PagedResult from '../models/paged-result';

class GetTodoItemChildrenRequest {
    id: number;

    constructor(id: number ) {
        this.id = id;
    }

    async handle() : Promise<TodoItem[]>
    {
        const handler = Container.get(GetTodoItemChildrenRequestHandler);
        return await handler.handle(this);
    }
}

@Service({ global: true })
class GetTodoItemChildrenRequestHandler implements IRequestHandler<GetTodoItemChildrenRequest,TodoItem[]>
{
    private readonly apiClient:ApiClient;

    constructor(container:ContainerInstance ) {
        this.apiClient = container.get(ApiClient);
    }
    
    async handle(request: GetTodoItemChildrenRequest) : Promise<TodoItem[]>
    {
        var result : TodoItem[];
        result=[];

        var pageInfo = new PageInfo(0,5);
        var pageResult:PagedResult<TodoItem> = await this.apiClient.getTodoItemChildren(request.id, pageInfo);

        result.push(...pageResult.items);

        while(result.length < pageResult.total_items)
        {
            pageInfo = new PageInfo(pageInfo.page_number+1,5);
            pageResult = await this.apiClient.getTodoItemChildren(request.id, pageInfo);
            result.push(...pageResult.items);
        }

        return result;
    }
}


export { GetTodoItemChildrenRequest,GetTodoItemChildrenRequestHandler};