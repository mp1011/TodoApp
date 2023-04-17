require 'sqlite3'
require 'active_record'
require_relative '../models/TodoItem'
require_relative '../../helpers/active_record_helpers'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'D:/GitHub/TodoApp/server/db/todoapp.db'
  )

ActiveRecord::Relation.include(ActiveRecordHelpers)
ActiveRecord::Base.include(ActiveRecordHelpers)

class DataContext 

    def todoItems 
        return TodoItemDbRecord.where("1=1")
    end 

    def saveTodoItem(item)
        
        dbItem = TodoItemDbRecord.new(text: item.text)
        dbItem.save

    end 
    
    def testMethod
        return TodoItemDbRecord
            .where("text LIKE '%item%'")
            .map{|x| x.Text}
            .join(",")
    end
    
end 