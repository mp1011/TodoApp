class String 
    def set_query_value(key, value)
        path, query = self.split('?')
        query ||= ''
        contains_key = false 

        query_parts = query.split('&').map do |x|            
            part_key,part_value = x.split('=')
            if part_key == key && value.present?
                contains_key = true 
                "#{part_key}=#{value}"
            elsif part_key == key 
                nil 
            else 
                x 
            end 
        end 

        unless contains_key || value.nil?
            query_parts << "#{key}=#{value}"
        end 

        query_string = query_parts
                        .select { |x| x.present? }
                        .join '&'

        if query_string.empty?
            path 
        else 
            "#{path}?#{query_string}"
        end
    end 
end 