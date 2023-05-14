import React from 'react';
import TodoItem from '../models/todo-item';
import TodoComponent from './todo-component';
import TodoDropTarget from './todo-drop-target';
import { DndProvider, useDragDropManager } from 'react-dnd'
import { HTML5Backend } from 'react-dnd-html5-backend'

function TodoList(props: { items:TodoItem[]}) {
  
    var place = 1
    const list = props.items.map((item) => (                
        <div>   
            <TodoDropTarget order={place++}/>                                    
            <TodoComponent key={item.text} item={item} /> 
        </div> ));

    return (
        <DndProvider backend={HTML5Backend}>
            <div className="d-flex flex-column">   
                {list}
                <TodoDropTarget order={place++}/>
            </div>  
        </DndProvider>                 
    );
}

export default TodoList;