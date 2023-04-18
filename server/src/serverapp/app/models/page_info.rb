# Stores a 0-based page number and number of items per page
class PageInfo
    attr_accessor :page_number, :page_size

    def skip
        @page_number * @page_size
    end

    def initialize(page_number, page_size)
        @page_number = page_number
        @page_size = page_size.zero? ? 50 : page_size
    end
end
