module ActiveRecordHelpers

    def get_page(pageNumber, pageSize)
        skip = pageNumber*pageSize;
        self.order(:id)
            .offset(skip)
            .limit(pageSize)
            .to_a
    end 

end 