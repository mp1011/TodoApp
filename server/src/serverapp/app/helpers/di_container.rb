require 'dry-container'
require 'dry-auto_inject'

$container = Dry::Container.new
$injector = Dry::AutoInject($container)

require_relative '../persistance/services/data_context'
require_relative '../services/auth_service'

$container.register('auth_service') { AuthService.new }
$container.register('data_context') { DataContext.new }
