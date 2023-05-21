import ApiClient from '../services/api-client';
import { GetTodoItemsRequest } from '../requests/get-todo-items';
import TodoItem from '../models/todo-item';
import PagedResult from '../models/paged-result';
import 'reflect-metadata'; 
import { AddTodoItemRequest } from '../requests/add-todo-item';
import { Container } from 'typedi';

describe('ApiClient', () => {
    describe('getTodoItems', () => {
        it('should return a non-empty collection', async () => {
            const clientApi = Container.get(ApiClient);
            const todoItems = (await clientApi.getTodoItems()) as PagedResult<TodoItem>;

            expect(todoItems.items.length).toBeGreaterThan(0);
        })
    })
})
    
describe('GetTodoItems', () => {
    it('should get all records', async () => {       
        const items = await new GetTodoItemsRequest().handle() as TodoItem[];
        expect(items.length).toBeGreaterThanOrEqual(10);
    });

    it('should get all records with text', async () => {       
        const items = await new GetTodoItemsRequest("my new item").handle() as TodoItem[];
        expect(items.length).toBe(2);
    })
})

describe('AddTodoRequest', () => {
    it('should insert a record', async () => {  
        const text = `TEST_${Date.now()}`;
        await new AddTodoItemRequest(text).handle();
        const items = await new GetTodoItemsRequest(text).handle() as TodoItem[];
        expect(items.length).toBe(1);
    })
})