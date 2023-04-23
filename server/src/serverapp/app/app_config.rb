require 'yaml'

class AppConfig 
    include Singleton
    
    def initialize
        puts Dir.pwd
        @config = YAML.load_file('config.yaml')
    end 
    
    def database
        @config["database"]
    end 

end 