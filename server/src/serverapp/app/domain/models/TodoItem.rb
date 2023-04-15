requires_relative '../contracts/BaseModel'

class TodoItem
    include BaseModel

    def initialize(id, text)
        super(id)
        @text=text 
    end 

end class 