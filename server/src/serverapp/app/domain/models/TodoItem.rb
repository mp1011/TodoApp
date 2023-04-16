require_relative '../contracts/BaseModel'

class TodoItem
    include BaseModel

    attr_accessor :id 
    attr_accessor :text 
    
    def self.fromJson(json)
        TodoItem.new(json["id"], json["text"])    
    end 

    def self.fromJsonArray(jsonArray)
        jsonArray.map { |x| TodoItem.fromJson(x)}
    end 

    def self.mapFrom(src)
        item = self.new
        item.id = src.id 
        item.text = src.text
        item 
    end 

    def initialize(id=0, text="")
        super(id)
        @text=text 
    end 

end 