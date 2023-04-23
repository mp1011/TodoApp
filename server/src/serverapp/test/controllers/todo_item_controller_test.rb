require 'test_helper'
require_relative '../../app/models/data_models/todo_item'
require_relative '../../app/models/paged_result'

class TodoItemControllerTest < ActionDispatch::IntegrationTest

    test 'search Todo Item by text' do 

        get '/todoitem', params: { search: 'new item' }

        paged_result = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        puts "total items = #{paged_result.total_items}"
        todo_items = paged_result.items

        assert_not_empty todo_items

        puts "GET /todoitem -> #{todo_items}"
   
        todo_items.each do |x|
            assert_includes x.text, 'new item'
        end

    end 

    test 'insert new Todo Item' do
        
        item_text = "UNIT TEST #{SecureRandom.uuid}"

        get '/todoitem', params: { search: item_text}
        initial_response = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        assert_empty initial_response.items
       
        post '/todoitem', params: { text: item_text }, as: :json
        assert_response :success
        puts "post response = #{response.body}"
        
        get '/todoitem', params: { search: item_text}
        new_array = PagedResult.from_json(JSON.parse(response.body), TodoItem)
        assert_not_empty new_array.items

        puts new_array
   
    end

end
