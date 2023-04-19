import TodoItem from '../models/todo-item';
import { Service } from 'typedi';

@Service({ global: true })
class ApiClient {

    //todo, get from settings
    hostName:string = "http:\\\\localhost:3000\\";

    async getTodoItems() : Promise<TodoItem[]>
    {
        return this.getJson<TodoItem[]>("todoitem");
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