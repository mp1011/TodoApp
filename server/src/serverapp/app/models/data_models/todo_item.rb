class TodoItem < ActiveRecord::Base 
    self.table_name = 'TodoItem'
    
    include JsonLoadable

    def self.from_json(json)
        TodoItem.new(id:json['id'], text:json['text'], created_by:json['created_by'], sort_order:json['sort_order'])
    end 

    def self.from_json_array(json_array)
        json_array.map { |x| TodoItem.from_json(x)}
    end 
end 