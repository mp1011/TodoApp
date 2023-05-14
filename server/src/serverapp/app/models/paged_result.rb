class PagedResult
    include JsonLoadable
    attr_reader :total_items, :page_info, :items

    def total_pages 
        @total_items / @page_info.page_size
    end 

    def initialize(items, page_info, total_items)
        @items = items 
        @page_info = page_info
        @total_items = total_items
    end 

    def self.from_json(json, item_class)

        page_info = PageInfo.from_json(json['page_info'])
        total_items = json['total_items'].to_i
        items = json['items']
                    .map { |x| item_class.from_json(x)}

        PagedResult.new(items, page_info, total_items)
    end 

end 