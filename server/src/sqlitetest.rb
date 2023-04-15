require 'sqlite3'
require 'active_record'

module ActiveRecordHelpers

  def get_page(pageNumber, pageSize)
      skip = pageNumber*pageSize;
      self.order(:id)
          .offset(skip)
          .limit(pageSize)
          .to_a
  end 

end 

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'D:/GitHub/TodoApp/server/db/todoapp.db'
  )

ActiveRecord::Base.include(ActiveRecordHelpers)

class ActiveRecord::Relation

  def get_page3(pageNumber, pageSize)
    skip = pageNumber*pageSize;
    self.order(:id)
        .offset(skip)
        .limit(pageSize)
        .to_a
  end 

end 

class TodoItem < ActiveRecord::Base 
    include ActiveRecordHelpers
    
    self.table_name = 'TodoItem'

    def get_page2(pageNumber, pageSize)
      skip = pageNumber*pageSize;
      self.order(:id)
          .offset(skip)
          .limit(pageSize)
          .to_a
    end 
end 

puts TodoItem
  .limit(100)
  .get_page3(0,5)
  .map{|x| x.Text}