import React from 'react';
import TodoItem from '../models/todo-item';
import TodoComponent from './todo-component';

function TodoList(props: { items:TodoItem[]}) {
  
    return (

        <div className="d-flex flex-column">
          {props.items.map((item) => (        
            <TodoComponent key={item.text} item={item} /> 
          ))}
        </div>           
    );
}

export default TodoList;
