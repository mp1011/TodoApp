import React from 'react';
import { useState } from 'react';
import TodoItem from '../models/todo-item';
import { useDrop } from 'react-dnd';
import { useDragDropManager } from 'react-dnd'
import { ReorderTodoItemCommand } from '../requests/reorder-todo-item-command';

function TodoDropTarget(props: { order:number, itemOrderChanged:(arg: TodoItem[])=>void}) {

    const dndManager = useDragDropManager();
    const isDragging = dndManager.getMonitor().isDragging();

    const [{ canDrop, isOver }, drop] = useDrop(() => ({
        accept: 'todo-item',
        drop: async (item:TodoItem, monitor:any) => {
            const sorted = await new ReorderTodoItemCommand(item.id, props.order).handle();
            props.itemOrderChanged(sorted);
        },
        collect: (monitor) => ({
          isOver: monitor.isOver(),
          canDrop: monitor.canDrop()
        })
      }), [props.order])
     
    return <div className='drop-target' ref={drop} hidden={!isDragging} />
   
            
}

export default TodoDropTarget;
