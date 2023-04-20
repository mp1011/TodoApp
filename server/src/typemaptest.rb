require 'json'
require_relative '.\serverapp\app\models\paged_result'
require_relative '.\serverapp\app\models\data_models\todo_item'

class Duck

    attr_accessor :name

    def initialize(n)
        @name=n
    end 

    def quack
        "i am a duck and my name is #{@name}"
    end 
end 

class Goose

    def initialize(src:)
        @name = src.name
    end

    def quack
        "i am a goose and my name is #{@name}"
    end
end

duck = Duck.new('frank')
goose = Goose.new(src: duck)

puts duck.quack
puts goose.quack

json = '{"items":[{"id":1,"text":"my new item"},{"id":2,"text":"my new item from AR"},{"id":3,"text":"three"},{"id":4,"text":"four"},{"id":5,"text":"five"},{"id":6,"text":"666"},{"id":7,"text":"777"},{"id":8,"text":"888"},{"id":9,"text":"999"},{"id":10,"text":"ten"}],"page_info":{"page_number":0,"page_size":50},"total_items":10}'
paged_result = PagedResult.from_json(JSON.parse(json), TodoItem)

puts paged_result
