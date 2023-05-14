import React from 'react';
import { useState } from 'react';
import TodoItem from '../models/todo-item';
import { useDrop } from 'react-dnd';
import { useDragDropManager } from 'react-dnd'

function TodoDropTarget(props: { order:number}) {

    const dndManager = useDragDropManager();
    const isDragging = dndManager.getMonitor().isDragging();

    const [{ canDrop, isOver }, drop] = useDrop(() => ({
        accept: 'todo-item',
        drop: (item:TodoItem, monitor:any) => {
            alert(item.text);
        },
        collect: (monitor) => ({
          isOver: monitor.isOver(),
          canDrop: monitor.canDrop()
        })
      }), [props.order])
     
    return <div className='drop-target' ref={drop} hidden={!isDragging} />
   
            
}

export default TodoDropTarget;
