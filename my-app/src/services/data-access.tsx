import TodoItem from '../models/todo-item';
import { Service, ContainerInstance } from 'typedi';
import ApiClient from './api-client';
import PageInfo from '../models/page-info';
import PagedResult from '../models/paged-result';

@Service({ global: true })
class DataAccess {

    private readonly api_client:ApiClient;

    constructor(container:ContainerInstance ) {
        this.api_client = container.get(ApiClient);
    }

    async saveTodoItem(item:TodoItem) : Promise<TodoItem> {
        return await this.api_client.saveTodoItem(item);
    }

    async getTodoItems(searchText?:string) : Promise<TodoItem[]> {

        var result : TodoItem[];
        result=[];

        var pageInfo = new PageInfo(0,5);
        var pageResult:PagedResult<TodoItem> = await this.api_client.getTodoItems(searchText, pageInfo);

        result.push(...pageResult.items);

        while(result.length < pageResult.total_items)
        {
            pageInfo = new PageInfo(pageInfo.page_number+1,5);
            pageResult = await this.api_client.getTodoItems(searchText, pageInfo);
            result.push(...pageResult.items);
        }

        return result;
    }

}

export default DataAccess;