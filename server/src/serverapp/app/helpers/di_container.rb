require 'dry-container'
require 'dry-auto_inject'
require_relative '../persistance/services/DataContext'

container = Dry::Container.new 
$injector = Dry::AutoInject(container)

container.register("dataContext") { DataContext.new }