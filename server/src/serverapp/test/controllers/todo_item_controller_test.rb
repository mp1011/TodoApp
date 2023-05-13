require 'test_helper'

class TodoItemControllerTest < ActionDispatch::IntegrationTest

    test 'search Todo Item by text' do 

        register_container_mockauth

        get '/todoitem', params: { search: 'new item' }

        paged_result = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        todo_items = paged_result.items

        assert_not_empty todo_items

        todo_items.each do |x|
            assert_includes x.text, 'new item'
        end

    end 

    test 'get Todo Item by page' do 

        register_container_mockauth

        get '/todoitem', params: { page_number:2, page_size:2}
        paged_result = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        
        assert_operator paged_result.total_items, :>=, 14
        assert_equal 2, paged_result.items.length
                 
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

end
