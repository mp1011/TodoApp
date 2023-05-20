import React from 'react';
import { useState } from 'react';
import TodoItem from '../models/todo-item';
import { useDrop } from 'react-dnd';
import { useDragDropManager } from 'react-dnd'
import Mediator from '../services/mediator';
import { ReorderTodoItemCommand } from '../requests/reorder-todo-item-command';

function TodoDropTarget(props: { order:number}) {

    const dndManager = useDragDropManager();
    const isDragging = dndManager.getMonitor().isDragging();

    const [{ canDrop, isOver }, drop] = useDrop(() => ({
        accept: 'todo-item',
        drop: async (item:TodoItem, monitor:any) => {
            const sorted = await Mediator.send(new ReorderTodoItemCommand(item.id, props.order));
            console.log(sorted);
        },
        collect: (monitor) => ({
          isOver: monitor.isOver(),
          canDrop: monitor.canDrop()
        })
      }), [props.order])
     
    return <div className='drop-target' ref={drop} hidden={!isDragging} />
   
            
}

export default TodoDropTarget;
