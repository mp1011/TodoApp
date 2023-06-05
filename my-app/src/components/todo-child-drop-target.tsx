import React from 'react';
import { useState } from 'react';
import TodoItem from '../models/todo-item';
import { useDrop } from 'react-dnd';
import { useDragDropManager } from 'react-dnd'
import { SetTodoParentCommand } from '../requests/set-todo-parent-command';

function TodoChildDropTarget(props: { parent:TodoItem, childrenChanged:(arg: TodoItem)=>void}) {

    const dndManager = useDragDropManager();
    const isDragging = dndManager.getMonitor().isDragging();

    const [{ canDrop, isOver }, drop] = useDrop(() => ({
        accept: 'todo-item',
        drop: async (item:TodoItem, monitor:any) => {
            await new SetTodoParentCommand(item.id, props.parent.id).handle();
            props.childrenChanged(props.parent);
        },
        collect: (monitor) => ({
          isOver: monitor.isOver(),
          canDrop: monitor.canDrop()
        })
      }), [props.parent])
     
    return  <div className='child-drop-target' ref={drop} hidden={!isDragging} >
              <i className="fa-sharp fa-solid fa-circle-plus text-dark"></i>
            </div>         
}

export default TodoChildDropTarget;
