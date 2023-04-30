require_relative './concerns/json_loadable'
# Stores a 0-based page number and number of items per page
class PageInfo
    include JsonLoadable

    attr_accessor :page_number, :page_size

    def skip
        @page_number * @page_size
    end

    def initialize(page_number, page_size)
        @page_number = page_number
        @page_size = page_size.zero? ? 50 : page_size
    end

    def self.from_json(json)
        PageInfo.new(json['page_number'].to_i, json['page_size'].to_i)
    end

    def self.from_request(request_params)
        page_number = request_params[:page_number].to_i || 0
        page_size = request_params[:page_size].to_i || 5
      
        PageInfo.new(page_number, page_size)
    end 
    
end
