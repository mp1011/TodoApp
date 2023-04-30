require 'dry-container'
require 'dry-auto_inject'

$registered=false
$container = Dry::Container.new
$injector = Dry::AutoInject($container)

require_relative '../persistance/services/data_context'
require_relative '../services/auth_service'

def register_container 
    puts '---------------register_container'
    if not $registered
        $registered = true 
        $container.register('auth_service') { AuthService.new }
        $container.register('data_context') { DataContext.new }
    end 
end 

def register_container_mockauth
    puts '---------------register_container_mockauth'
    $container.instance_variable_get('@_container').delete('auth_service')
    $container.register('auth_service') { MockAuthService.new }
end 
