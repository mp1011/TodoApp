class User < ActiveRecord::Base 
    self.table_name = 'User'
    include JsonLoadable

    def self.from_json(json)
        User.new(json['id'], json['name'], json['email'])
    end 

end 