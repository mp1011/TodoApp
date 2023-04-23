import ApiClient from '../services/api-client';
import Mediator from '../services/mediator';
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
        const items = await Mediator.send(new GetTodoItemsRequest()) as TodoItem[];
        expect(items.length).toBeGreaterThanOrEqual(10);
    });

    it('should get all records with text', async () => {       
        const items = await Mediator.send(new GetTodoItemsRequest("my new item")) as TodoItem[];
        expect(items.length).toBe(2);
    })
})

describe('AddTodoRequest', () => {
    it('should insert a record', async () => {  
        const text = `TEST_${Date.now()}`;
        await Mediator.send(new AddTodoItemRequest(text));
        const items = await Mediator.send(new GetTodoItemsRequest(text)) as TodoItem[];
        expect(items.length).toBe(1);
    })
})