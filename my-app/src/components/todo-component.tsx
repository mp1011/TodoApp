import React from 'react';
import TodoItem from '../models/todo-item';

function TodoComponent(props: { item:TodoItem}) {
  
    return (

        <span>{props.item.text}</span>
           
    );
}

export default TodoComponent;
