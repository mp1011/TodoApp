require 'test_helper'

class TodoItemControllerTest < ActionDispatch::IntegrationTest

    test 'search Todo Item by text' do 

        register_container_mockauth

        get '/todoitem', params: { search: 'Sample 11' }

        paged_result = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        todo_items = paged_result.items

        assert_not_empty todo_items

        todo_items.each do |x|
            assert_includes x.text, 'Sample 11'
        end

    end 

    test 'get Todo Item by page' do 

        register_container_mockauth

        get '/todoitem', params: { page_number:2, page_size:2}
        paged_result = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        
        assert_operator paged_result.total_items, :>=, 10
        assert_equal 2, paged_result.items.length
                 
    end 

    test 'get children of item' do 
        register_container_mockauth

        get '/todoitem/22/children', params: { page_number:0, page_size:5}
        paged_result = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        
        assert_equal "Child", paged_result.items.first.text 
    end 

    test 'insert new Todo Item' do
        
        register_container_mockauth

        item_text = "UNIT TEST #{SecureRandom.uuid}"

        get '/todoitem', params: { search: item_text}
        initial_response = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        assert_empty initial_response.items
       
        post '/todoitem', params: { text: item_text }, as: :json
        assert_response :success
        
        get '/todoitem', params: { search: item_text}
        new_array = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        assert_not_empty new_array.items

    end

    test 'inserted item gets next highest sort number' do

        register_container_mockauth

        #get the current highest order 
        last_item = TodoItem.where(created_by:1)
                            .order(sort_order: :desc).first.sort_order

        #post a new item
        post '/todoitem', params: { text: "Should have order #{last_item + 1}" }, as: :json
        assert_response :success

        posted_item = TodoItem.from_json(JSON.parse(response.body))
        assert_equal last_item + 1, posted_item.sort_order 

    end 

    test 'can reorder todo item' do 
        register_container_mockauth

        get '/todoitem', params: { }
        initial_response = PagedResult.from_json(JSON.parse(response.body), TodoItem)

        item_to_change = initial_response.items[3];

        #reorder
        put "/todoitem/#{item_to_change.id}/changesort", params: { new_sort_order: 1 }, as: :json
     
        get '/todoitem', params: { }
        new_response = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        assert_equal item_to_change.id, new_response.items[0].id        
    end 

    test 'can update todo item' do
        register_container_mockauth

        get '/todoitem', params: { }
        initial_response = PagedResult.from_json(JSON.parse(response.body), TodoItem)

        item_to_change = initial_response.items[0];

        was_check = item_to_change.check

        put "/todoitem/#{item_to_change.id}", params: { check: !item_to_change.check }, as: :json
        assert_response :success

        get "/todoitem/#{item_to_change.id}"
        assert_response :success

        new_response = TodoItem.from_json(JSON.parse(response.body))

        assert_equal !was_check, new_response.check  
    end 

    test 'can set parent of item' do
        register_container_mockauth

        parent_id = 22
        item_id = 20 

        get "/todoitem/#{parent_id}/children", params: { page_number:0, page_size:100}
        children_before = PagedResult.from_json(JSON.parse(response.body), TodoItem).items

        assert_nil children_before.find { |x| x.id == item_id }

        put "/todoitem/#{item_id}/setparent/#{parent_id}"
        get "/todoitem/#{parent_id}/children", params: { page_number:0, page_size:100}
        children_after = PagedResult.from_json(JSON.parse(response.body), TodoItem).items

        assert_not_nil children_after.find { |x| x.id == item_id }

    end

    test 'gives 404 if not found' do 
        register_container_mockauth
        get "/todoitem/9999999"
        assert_response :not_found
    end 

    test 'gives 403 if record belongs to another user' do 
        register_container_mockauth
        get "/todoitem/21"
        assert_response :forbidden
    end 
end
