class SetTodoParentTest < ActiveSupport::TestCase

    test 'can add item to another' do 
        current_user = User.where("id = 1").first
      
        parent = TodoItem.find{|x| x.text == 'Parent'}
        item = TodoItem.find{|x| x.text == 'Sample 2'}

        SetTodoParent.new(item, parent, current_user).handle

        parent = TodoItem.find{|x| x.text == 'Parent'}
        item = TodoItem.find{|x| x.text == 'Sample 2'}

        assert_equal parent.id, item.parent_id
        assert_equal 5, item.sort_order
        assert_equal 2, TodoItem.find{|x| x.text == 'Sample 3'}.sort_order
    end
end 