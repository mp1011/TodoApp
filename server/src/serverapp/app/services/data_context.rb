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

        last_item = todo_items
                        .where("created_by = ?", user_id)
                        .order("sort_order desc")
                        .first 

        new_order = 1 if last_item.nil? 
        new_order = last_item.sort_order + 1 if last_item.present?

        db_item = TodoItem.new(text: item.text, created_by: user_id, sort_order: new_order)
       
        db_item.save
        db_item
    end

    def save_user(user)
        db_user = User.new(name: user.name, email: user.email)
        db_user.save
        db_user
    end 

    def update_record(klass, id, properties, current_user_id)
        current_record = klass.find(id) 

        raise "Record not found" if current_record.nil?
        raise "This record belongs to another user" if current_record.created_by != current_user_id

        properties.each do |key,value|            
            current_record[key] = value if current_record.respond_to?(key)
        end 

        current_record.save
        current_record    
    end 

end
