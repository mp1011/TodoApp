ActiveRecord::Relation.include(ActiveRecordHelpers)
ActiveRecord::Base.include(ActiveRecordHelpers)

# provides basic access and save operations for all tables
class DataContext
    
    def todo_items
        TodoItem.where('1=1')
    end

    def users 
        User.where('1=1')
    end 

    def save_todo_item(item, user_id)        
        db_item = TodoItem.new(text: item.text, created_by: user_id)
       
        db_item.save
        db_item
    end

    def save_user(user)
        db_user = User.new(name: user.name, email: user.email)
        db_user.save
        db_user
    end 

end
