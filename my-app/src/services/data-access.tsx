import TodoItem from '../models/todo-item';
import { Service } from 'typedi';

@Service({ global: true })
class DataAccess {
    items: TodoItem[];

    constructor() {
        this.items = [];
    }

    insertTodoItem(item:TodoItem) : TodoItem {
        
        this.items.push(item);
        return item;
    }

    getTodoItems() : TodoItem[] {
        return this.items;
    }

}

export default DataAccess;