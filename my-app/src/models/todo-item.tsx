class TodoItem {
    readonly id: number;
    readonly text: string;
    readonly sort_order: number;
    readonly check: boolean;
    readonly question: boolean;
    readonly danger: boolean;
    readonly blocked: boolean;
    

    constructor(id:number, 
                text: string, 
                sort_order: number=0, 
                check: boolean=false, 
                question: boolean=false,
                danger: boolean=false,
                blocked: boolean=false) {
        this.id = id;
        this.text = text;
        this.sort_order = sort_order;
        this.check=check;
        this.question=question;
        this.danger=danger;
        this.blocked=blocked;
    }
}

export default TodoItem;