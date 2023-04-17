class PageInfo 
    attr_accessor :pageNumber 
    attr_accessor :pageSize 

    def skip 
        @pageNumber * @pageSize
    end
    
    def initialize(pageNumber, pageSize)
        @pageNumber = pageNumber;
        @pageSize = pageSize;

        if(@pageSize == 0)
            @pageSize = 50
        end 
    end 

end 