require_relative '../concerns/base_model'

class User
    include BaseModel

    attr_accessor :id, :name, :email

    def initialize(id = 0, name = '', email = '')
        super(id)
        @name=name 
        @email = email
    end 

    def self.from_json(json)
        User.new(json['id'], json['name'], json['email'])
    end 

    def self.map_from(src)
        item = new
        item.id = src.id
        item.name = src.name
        item.email = src.email
        item
    end 

    

end 