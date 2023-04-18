module ActiveRecordHelpers

    def get_page(page_info)
        order(:id)
            .offset(page_info.skip)
            .limit(page_info.page_size)
            .to_a
    end

end 