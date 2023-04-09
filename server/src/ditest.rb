require 'dry-container'
require 'dry-auto_inject'

container = Dry::Container.new 
$injector = Dry::AutoInject(container)

class Dependency1     
    def say 
        puts "Hello DI World!!!"
    end 
end 

class Dependency2   
    include $injector["dependency1"]

    def say 
        dependency1.say
    end 
end 

container.register("dependency1") { Dependency1.new }
container.register("dependency2") { Dependency2.new }

class GreetingWithAutoInjection
    include $injector["dependency2"]
  
    def say 
        dependency2.say
    end 
end 

gwi2 = GreetingWithAutoInjection.new()
gwi2.say 