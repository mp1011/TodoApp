class TodoItem {
    readonly id: number;
    readonly text: string;
    readonly sort_order: number;

    constructor(id:number, text: string, sort_order: number=0) {
        this.id = id;
        this.text = text;
        this.sort_order = sort_order;
    }
}

export default TodoItem;