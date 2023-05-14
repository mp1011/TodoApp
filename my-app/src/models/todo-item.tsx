class TodoItem {
    readonly text: string;
    readonly sort_order: number;

    constructor(text: string, sort_order: number=0) {
        this.text = text;
        this.sort_order = sort_order;
    }
}

export default TodoItem;