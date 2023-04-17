module ActiveRecordHelpers

    def get_page(pageInfo)
        self.order(:id)
            .offset(pageInfo.skip)
            .limit(pageInfo.pageSize)
            .to_a
    end 

end 