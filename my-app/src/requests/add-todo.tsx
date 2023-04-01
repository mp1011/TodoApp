import TodoItem from '../models/todo-item';
import DataAccess from '../services/data-access';
import { Service, ContainerInstance } from 'typedi';


class AddTodoRequest {
    text: string;

    constructor(text: string ) {
        this.text = text;
    }
}

@Service()
class AddTodoRequestHandler 
{
    private dataAccess : DataAccess;

    constructor(container : ContainerInstance) {
        this.dataAccess = container.get(DataAccess);
    }

    handle(request:AddTodoRequest)
    {
        return this.dataAccess
            .insertTodoItem(new TodoItem(request.text));
    }
}


export { AddTodoRequest,AddTodoRequestHandler};