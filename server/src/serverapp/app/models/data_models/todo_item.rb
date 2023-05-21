class TodoItem < ActiveRecord::Base 
    self.table_name = 'TodoItem'
    
    include JsonLoadable

    def self.from_json(json)
        TodoItem.new(   id: json['id'], 
                        text: json['text'], 
                        created_by: json['created_by'], 
                        sort_order: json['sort_order'],
                        check: json['check'],
                        question: json['question'],
                        danger: json['danger'],
                        blocked: json['blocked'],
                        parent_id: json['parent_id'])
    end 

    def self.from_json_array(json_array)
        json_array.map { |x| TodoItem.from_json(x)}
    end 
end 