import ApiClient from '../services/api-client';

describe('ApiClient', () => {
    describe('getTodoItems', () => {
        it('should return a non-empty collection', async () => {
            const clientApi = new ApiClient();
            const todoItems = await clientApi.getTodoItems();

            expect(todoItems.length).toBeGreaterThan(0);
        })
    })
})
       