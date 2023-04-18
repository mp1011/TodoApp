require_relative '../concerns/base_model'

class TodoItem
    include BaseModel

    attr_accessor :id, :text

    def self.from_json(json)
        TodoItem.new(json["id"], json["text"])    
    end 

    def self.from_json_array(json_array)
        json_array.map { |x| TodoItem.from_json(x)}
    end 

    def self.map_from(src)
        item = new
        item.id = src.id
        item.text = src.text
        item 
    end 

    def initialize(id=0, text='')
        super(id)
        @text=text 
    end 

end 