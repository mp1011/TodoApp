module JsonLoadable

    def self.from_json(json)
        raise NotImplementedError, "from_json not implemented on this type"
    end 

end 