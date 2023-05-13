require_relative "boot"
require 'googleauth'
require 'jwt'
require "rails/all"

require_relative '../app/helpers/string'
require_relative '../app/helpers/active_record_helpers'    
require_relative '../app/helpers/di_container'

require_relative '../app/models/concerns/json_loadable'

require_relative '../app/models/page_info'
require_relative '../app/models/paged_result'

require_relative '../app/models/data_models/todo_item'
require_relative '../app/models/data_models/user'

require_relative '../app/features/save_user'
require_relative '../app/features/get_todo_items'
require_relative '../app/features/save_todo_item'

require_relative '../app/services/auth_service'

require_relative '../app/controllers/concerns/authenticated_controller'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Serverapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
