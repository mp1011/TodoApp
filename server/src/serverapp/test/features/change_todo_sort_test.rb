class ChangeTodoSortTest < ActiveSupport::TestCase
    test  'can change order of todo items' do
        
        current_user = User.where("id = 1").first
      
        #from
        #A B C D E F
        #1 2 3 4 5 6

        #to
        #C A B D E F
        #1 2 3 4 5 6
        before = TodoItem.where(created_by:1, parent_id:nil, sort_order: 2).first
        item = TodoItem.where(created_by:1, parent_id:nil, sort_order: 3).first
        after = TodoItem.where(created_by:1, parent_id:nil, sort_order: 4).first

        command = ChangeTodoSort.new(item, 1, current_user).handle()
       
        new_before = TodoItem.where('id = ?', before.id).first
        new_item = TodoItem.where('id = ?', item.id).first
        new_after = TodoItem.where('id = ?', after.id).first
        
        assert_equal 3, new_before.sort_order
        assert_equal 1, new_item.sort_order
        assert_equal 4, new_after.sort_order

    end 

    test  'returns all items that have changed order' do
        
        current_user = User.where("id = 1").first
        items = TodoItem.where('created_by = 1').map{|x| x.as_json}        
        item = TodoItem.where('created_by = 1 and sort_order = 3').first
     
        changed_items = ChangeTodoSort.new(item, 1, current_user).handle()
        assert_operator changed_items.length, :>=, 3

        changed_items.each do |x|
            original = items.find { |i| i['id'] == x.id }
            assert_not_equal original['sort_order'], x.sort_order
        end 

    end 

end 