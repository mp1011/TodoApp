import ApiClient from '../services/api-client';
import { GetTodoItemsRequest } from '../requests/get-todo-items';
import { AddTodoItemRequest } from '../requests/add-todo-item';
import { UpdateTodoItemCommand } from '../requests/update-todo-item-command';
import TodoItem from '../models/todo-item';
import PagedResult from '../models/paged-result';
import 'reflect-metadata'; 
import { Container } from 'typedi';
import MockSession from './mocks/mock-session';
import Session from '../services/session';

Container.set(Session, new MockSession());

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
        const items = await new GetTodoItemsRequest("Sample 2").handle() as TodoItem[];
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

describe('UpdateTodoItemCommand', () => {
    it('should update checked field', async () => {  
        
        const result = await new UpdateTodoItemCommand(1, { check: true }).handle();
        expect(result.check).toBe(true);

        const result2 = await new UpdateTodoItemCommand(1, { check: false }).handle();
        expect(result2.check).toBe(false);

    })
})