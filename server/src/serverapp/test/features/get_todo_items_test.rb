class GetTodoItemsTest < ActiveSupport::TestCase
    test  'only top level items are returned' do
        current_user = User.where("id = 1").first
        items = GetTodoItems.new(nil, PageInfo.new(0,100), current_user).handle.items
        
        should_include = items.find{|x| x.text == "Parent"}
        should_not_include = items.find{|x| x.text == "Child"}

        assert_not_nil should_include
        assert_nil should_not_include
    end 

    test 'can get children of item' do
        current_user = User.where("id = 1").first
        items = GetTodoItems.new("Parent", PageInfo.new(0,100), current_user).handle.items
        
        parent = items.first 
        child_items = GetTodoItems.new(nil, PageInfo.new(0,100), current_user, parent.id).handle.items
        
        assert_equal "Child", child_items[0].text

    end 
end 