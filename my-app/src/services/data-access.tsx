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

    insertTodoItem(item:TodoItem) : TodoItem {
        return item;
    }

    async getTodoItems() : Promise<TodoItem[]> {

        var result : TodoItem[];
        result=[];

        var pageInfo = new PageInfo(0,5);
        var pageResult:PagedResult<TodoItem> = await this.api_client.getTodoItems(pageInfo);

        result.push(...pageResult.items);

        while(result.length < pageResult.total_items)
        {
            pageInfo = new PageInfo(pageInfo.page_number+1,5);
            pageResult = await this.api_client.getTodoItems(pageInfo);
            result.push(...pageResult.items);
        }

        return result;
    }

}

export default DataAccess;