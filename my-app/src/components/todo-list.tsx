import React from 'react';
import TodoItem from '../models/todo-item';
import TodoComponent from './todo-component';
import TodoDropTarget from './todo-drop-target';
import { DndProvider } from 'react-dnd'
import { HTML5Backend } from 'react-dnd-html5-backend'

function TodoList(props: { 
    items:TodoItem[], 
    itemOrderChanged:(arg: TodoItem[])=>void,
    itemChanged:(arg: TodoItem)=>void }) {
  
    var place = 1
    const list = props.items.map((item) => (                
        <div key={item.id}>   
            <TodoDropTarget order={place++} itemOrderChanged={props.itemOrderChanged}/>                                    
            <TodoComponent item={item} itemChanged={props.itemChanged} /> 
        </div> ));

    return (
        <DndProvider backend={HTML5Backend}>
            <div className="d-flex flex-column">   
                {list}
                <TodoDropTarget order={place++} itemOrderChanged={props.itemOrderChanged} />
            </div>  
        </DndProvider>                 
    );
}

export default TodoList;
