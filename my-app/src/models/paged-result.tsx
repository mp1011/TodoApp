import PageInfo from "./page-info";

class PagedResult<T> {
    readonly total_items: number;
    readonly page_info : PageInfo;
    readonly items: T[]

    constructor(total_items:number, page_info : PageInfo, items:T[]) {
        this.total_items = total_items;
        this.page_info = page_info;
        this.items = items;
    }
}

export default PagedResult;