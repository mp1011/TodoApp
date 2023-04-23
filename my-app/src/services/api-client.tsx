import TodoItem from '../models/todo-item';
import { Service } from 'typedi';
import PagedResult from '../models/paged-result';
import PageInfo from '../models/page-info';

@Service({ global: true })
class ApiClient {

    //todo, get from settings
    hostName:string = "http:\\\\localhost:3000\\";

    async getTodoItems(searchText?:string, pageInfo?:PageInfo) : Promise<PagedResult<TodoItem>>
    {
        var query = "todoitem";

        const params = new URLSearchParams();
        if(pageInfo)
        {
            params.append('pageNumber', pageInfo.page_number.toString());
            params.append('pageSize', pageInfo.page_size.toString());
        }

        if(searchText)
        {
            params.append('search', searchText);
        }
       
        return this.getJson<PagedResult<TodoItem>>(`${query}?${params.toString()}`);
    }

    async saveTodoItem(todoItem:TodoItem) : Promise<TodoItem>
    {
        return await this.postJson<TodoItem>("todoitem", todoItem);
    }

    private async getJson<T>(url: string): Promise<T> {

        const response = await fetch(`${this.hostName}${url}`);
        if (!response.ok) {
          throw new Error(`Failed to fetch data from ${url}`);
        }
        const json = await response.json();
        return json as T;
    }

    private async postJson<T>(url:string, data:T) : Promise<T> {

        const response = await fetch(`${this.hostName}${url}`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
          });

          if (!response.ok) {
            throw new Error(`Failed to post data to ${url}`);
          }

          const json = await response.json();
          return json as T;
    }
}

export default ApiClient