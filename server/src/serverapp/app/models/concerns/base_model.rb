require_relative 'json_loadable'

module BaseModel
    include JsonLoadable
    def initialize(id)
        @id=id
    end 
end 