import TodoItem from '../models/todo-item';
import { Service } from 'typedi';
import PagedResult from '../models/paged-result';
import PageInfo from '../models/page-info';

@Service({ global: true })
class ApiClient {

    //todo, get from settings
    hostName:string = "http:\\\\localhost:3000\\";

    async getTodoItems(pageInfo?:PageInfo) : Promise<PagedResult<TodoItem>>
    {
        var query = "todoitem";
        if(pageInfo){
            query += `?pageNumber=${pageInfo.page_number}&pageSize=${pageInfo.page_size}`;
        }

        return this.getJson<PagedResult<TodoItem>>(query);
    }

    private async getJson<T>(url: string): Promise<T> {

        //todo, host name from settings
        const response = await fetch(`${this.hostName}${url}`);
        if (!response.ok) {
          throw new Error(`Failed to fetch data from ${url}`);
        }
        const json = await response.json();
        return json as T;
    }
}

export default ApiClient