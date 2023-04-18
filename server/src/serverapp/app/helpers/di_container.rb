require 'dry-container'
require 'dry-auto_inject'
require_relative '../persistance/services/data_context'

$container = Dry::Container.new
$injector = Dry::AutoInject($container)

$container.register('data_context') { DataContext.new }
