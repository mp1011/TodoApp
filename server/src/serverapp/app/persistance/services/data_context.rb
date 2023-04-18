require 'sqlite3'
require 'active_record'
require_relative '../models/TodoItem'
require_relative '../../helpers/active_record_helpers'
require_relative '../../app_config'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: AppConfig.instance.database
)

ActiveRecord::Relation.include(ActiveRecordHelpers)
ActiveRecord::Base.include(ActiveRecordHelpers)

# provides basic access and save operations for all tables
class DataContext

    def todo_items
        TodoItemDbRecord.where('1=1')
    end

    def save_todo_item(item)
        db_item = TodoItemDbRecord.new(text: item.text)
        db_item.save
    end
end
