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
