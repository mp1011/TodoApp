import React from 'react';
import TodoItem from '../models/todo-item';

function TodoComponent(props: { item:TodoItem}) {
  
    return (

        <div className="card my-2">
            <div className="card-body">
                <p className="card-text text-dark text-start">{props.item.text}</p>
            </div>
        </div>
           
    );
}

export default TodoComponent;
