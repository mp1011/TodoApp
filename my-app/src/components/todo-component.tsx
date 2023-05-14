import React from 'react';
import { useState } from 'react';
import TodoItem from '../models/todo-item';
import { useDrag, useDrop } from 'react-dnd';


function TodoComponent(props: { item:TodoItem }) {
    
    const [{ isDragging }, drag] = useDrag(() => ({
        type: 'todo-item',
        item: props.item,
        collect: (monitor) => ({
        isDragging: monitor.isDragging()
        })
    }))

        return (
            <div ref={drag} 
                className="card my-2"
                style={{
                    opacity: 1.0,
                    cursor: 'move'
                }}>
                <div className="card-body">
                    <p className="card-text text-dark text-start">
                        {props.item.text}                    
                    </p>                    
                </div>
            </div>);    
}

export default TodoComponent;
