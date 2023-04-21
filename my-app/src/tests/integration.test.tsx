import ApiClient from '../services/api-client';
import Mediator from '../services/mediator';
import { GetTodoItemsRequest } from '../requests/get-todo-items';
import TodoItem from '../models/todo-item';
import PagedResult from '../models/paged-result';
import 'reflect-metadata'; 

describe('ApiClient', () => {
    describe('getTodoItems', () => {
        it('should return a non-empty collection', async () => {
            const clientApi = new ApiClient();
            const todoItems = (await clientApi.getTodoItems()) as PagedResult<TodoItem>;

            expect(todoItems.items.length).toBeGreaterThan(0);
        })
    })
})
    
describe('GetTodoItems', () => {
    it('should get all records', async () => {       
        const items = await Mediator.send(new GetTodoItemsRequest()) as TodoItem[];
        expect(items.length).toBe(10);
    })
})