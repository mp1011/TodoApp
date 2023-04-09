require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'D:/GitHub/TodoApp/server/db/todoapp.db'
  )

class TodoItem < ActiveRecord::Base 
    self.table_name = 'TodoItem'
   # attr_accessor :id, :text
end 

# item = TodoItem.new()
# item.Text = "my new item from AR"

# if item.valid?
#   puts "valid"
#   item.save 
# else
#   puts "not valid!"
#   puts item.errors.full_messages
# end

# items = TodoItem.where("text LIKE '%item%'")
# text = items.map { |x| x.Text}
# puts text 

puts TodoItem
  .where("text LIKE '%item%'")
  .map{|x| x.Text}