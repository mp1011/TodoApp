require 'yaml'

class AppConfig 
    include Singleton
    
    def initialize
        @config = YAML.load_file('config.yaml')
    end 
    
    def database
        @config["database"]
    end 

end 