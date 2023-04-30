require 'sqlite3'
require 'active_record'
require_relative '../models/todo_item'
require_relative '../models/user'
require_relative '../../helpers/active_record_helpers'
require_relative '../../helpers/di_container'
require_relative '../../app_config'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: AppConfig.instance.database
)

ActiveRecord::Relation.include(ActiveRecordHelpers)
ActiveRecord::Base.include(ActiveRecordHelpers)

# provides basic access and save operations for all tables
class DataContext
    include $injector['auth_service']

    def todo_items
        TodoItemDbRecord.where('1=1')
    end

    def users 
        UserDbRecord.where('1=1')
    end 

    def save_todo_item(item)
        #can this be more general?
        db_item = TodoItemDbRecord.new(text: item.text)
        db_item.createdBy = auth_service.logged_in_user.id
        db_item.save
        db_item
    end

    def save_user(user)
        db_user = UserDbRecord.new(name: user.name, email: user.email)
        db_user.save
        db_user
    end 

end
