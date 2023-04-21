class PageInfo {
    readonly page_number: number;
    readonly page_size: number;
    
    constructor(page_number:number, page_size:number) {
        this.page_number = page_number;
        this.page_size = page_size;
    }
}

export default PageInfo;