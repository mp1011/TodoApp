require_relative '../concerns/base_model'
require_relative '../concerns/user_owned'

class TodoItem
    include BaseModel
    include UserOwned

    attr_accessor :id, :text, :created_by

    def self.from_json(json)
        TodoItem.new(json['id'], json['text'], json['created_by'])
    end 

    def self.from_json_array(json_array)
        json_array.map { |x| TodoItem.from_json(x)}
    end 

    def self.map_from(src)
        item = new
        item.id = src.id
        item.text = src.text
        item.created_by = src.created_by
        item 
    end 

    def initialize(id = 0, text = '', created_by = 0)
        super(id)
        @text=text 
        @created_by = created_by
    end 

end 