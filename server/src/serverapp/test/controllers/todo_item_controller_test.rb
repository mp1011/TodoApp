require "test_helper"
require_relative "../../app/domain/models/TodoItem"
class TodoItemControllerTest < ActionDispatch::IntegrationTest

    test "search Todo Item by text" do 

        get '/todoitem', params: { search: "new item"}
        todo_items = TodoItem.fromJsonArray(JSON.parse(response.body))

        assert_not_empty todo_items 

        puts "GET /todoitem -> #{todo_items}"
   
        todo_items.each do |x|
            assert_includes x.text, "new item"
        end 

    end 

    test "insert new Todo Item" do
        
        item_text = "UNIT TEST #{SecureRandom.uuid}"

        get '/todoitem', params: { search: item_text}
        initial_response = JSON.parse(response.body)
        assert_empty initial_response
       
        post '/todoitem', params: { text: item_text }, as: :json
        assert_response :success
        
        get '/todoitem', params: { search: item_text}
        new_array = JSON.parse(response.body)
        assert_not_empty new_array

        puts new_array
   
    end

   
end
