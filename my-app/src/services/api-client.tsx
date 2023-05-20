import TodoItem from '../models/todo-item';
import User from '../models/user';
import { ContainerInstance, Service } from 'typedi';
import PagedResult from '../models/paged-result';
import PageInfo from '../models/page-info';
import AppSettings from '../app-settings';
import Session from './session';

@Service({ global: true })
class ApiClient {

  private readonly app_settings:AppSettings;
  private readonly session:Session;

  constructor(container:ContainerInstance ) {
      this.app_settings = container.get(AppSettings);
      this.session = container.get(Session);
  }

  async getCurrentUser() : Promise<User> {
    return this.getJson<User>('user');
  }

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

    private getHeaders() : HeadersInit
    {
      if(this.session.token) 
        return { 
          'Authorization' : `Bearer ${this.session.token}`,
          'Content-Type': 'application/json'       
        }
      else 
        return {
          'Content-Type': 'application/json'
         };
    }

    public async getJson<T>(url: string): Promise<T> {

        const response = await fetch(`${this.app_settings.host_name}${url}`, {
          method: 'GET',
          headers: this.getHeaders()
        });

        if (!response.ok) {
          throw new Error(`Failed to fetch data from ${url}`);
        }

        const json = await response.json();
        return json as T;
    }

    public async postJson<T>(url:string, data:T) : Promise<T> {

        const response = await fetch(`${this.app_settings.host_name}${url}`, {
            method: 'POST',
            headers: this.getHeaders(),
            body: JSON.stringify(data)
          });

          if (!response.ok) {
            throw new Error(`Failed to post data to ${url}`);
          }

          const json = await response.json();
          return json as T;
    }

    public async putJson<TResult>(url:string) : Promise<TResult> {

      const response = await fetch(`${this.app_settings.host_name}${url}`, {
          method: 'PUT',
          headers: this.getHeaders()
        });

        if (!response.ok) {
          throw new Error(`Failed to post data to ${url}`);
        }

        const json = await response.json();
        return json as TResult;
  }
}

export default ApiClient