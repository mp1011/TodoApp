greetings = ["Hi","Hello","Good Morning"]
greetings.each do |x|
    puts "#{x}, World!"
end

GreetingStruct = Struct.new(:greeting,:who)
gs = GreetingStruct.new("Good night","moon");

puts "#{gs.greeting}, #{gs.who}"

moonGreetings = greetings.map { |x| GreetingStruct.new(x,"moon")}

moonGreetings.each do |x|
    puts "#{x.greeting}, #{x.who}!"
end

class GreetingClass
    def initialize(greeting,who)
        @greeting=greeting
        @who=who 
    end 

    def say
        puts "#{@greeting}, #{@who}!"
    end 
end 

sunGreetings = moonGreetings.map { |x| GreetingClass.new(x.greeting,"sun")}

sunGreetings.each { |x| x.say }


class BaseGreeting 
    def initialize(greeting,who)
        @greeting=greeting
        @who=who 
    end 

    def say 
        raise "not implemented"
    end 
end 

class GreetingClassWithBase < BaseGreeting
    def say
        puts "#{@greeting}, #{@who}!"
    end 
end 

g = GreetingClassWithBase.new("Hello","Mars")
g.say 

module GreetingModule 
    def initialize(greeting,who)
        @greeting=greeting
        @who=who 
    end 

    def say 
        raise "not implemented"
    end 
end 

class GreetingClassWithMixin 
    include GreetingModule

    def say
        puts "#{@greeting}, #{@who}!"
    end 
end 

g2 = GreetingClassWithBase.new("Hello","Saturn")
g2.say 