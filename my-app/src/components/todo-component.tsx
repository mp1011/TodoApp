import React from 'react';
import { useState, useEffect } from 'react';
import TodoItem from '../models/todo-item';
import { useDrag } from 'react-dnd';
import TodoStateButton from './todo-state-button';
import { UpdateTodoItemCommand } from '../requests/update-todo-item-command';
import { GetTodoItemChildrenRequest } from '../requests/get-todo-item-children';
import TodoChildDropTarget from './todo-child-drop-target';

function TodoComponent(props: { item:TodoItem, itemChanged:(arg: TodoItem)=>void }) {
    
    const [children, setChildren] = useState<TodoItem[]>([]);
    const [noChildren, setNoChildren] = useState<boolean>(false);

    const [{ isDragging }, drag] = useDrag(() => ({
        type: 'todo-item',
        item: props.item,
        collect: (monitor) => ({
        isDragging: monitor.isDragging()
        })
    }))


    useEffect(()=> {

        async function fetchData() {
               
          if((!children || children.length == 0) && !noChildren)
          {
            console.log("NC " + noChildren);
            const children = await new GetTodoItemChildrenRequest(props.item.id).handle();
            console.log("CL " + children.length);

            setChildren(children);
            setNoChildren(children.length === 0);
          }
        }
    
        fetchData();
    })

    const checkChanged = async (newValue:boolean) => {
        const changedItem = await new UpdateTodoItemCommand(props.item.id, { check: newValue }).handle();
        props.itemChanged(changedItem);
    };

    const dangerChanged = async (newValue:boolean) => {
        const changedItem = await new UpdateTodoItemCommand(props.item.id, { danger: newValue }).handle();
        props.itemChanged(changedItem);
    };

    const questionChanged = async (newValue:boolean) => {
        const changedItem = await new UpdateTodoItemCommand(props.item.id, { question: newValue }).handle();
        props.itemChanged(changedItem);
    };

    const blockedChanged = async (newValue:boolean) => {
        const changedItem = await new UpdateTodoItemCommand(props.item.id, { blocked: newValue }).handle();
        props.itemChanged(changedItem);
    };

    return (
        <div ref={drag} 
            className="card my-2"
            style={{
                opacity: 1.0,
                cursor: 'move'
            }}>
            <div className="card-header d-flex flex-row-reverse">

                <div className="todo-button-container">
                    <TodoStateButton iconClass='fa-check' value={props.item.check} value_changed={checkChanged} />
                    <TodoStateButton iconClass='fa-triangle-exclamation' value={props.item.danger} value_changed={dangerChanged} />
                    <TodoStateButton iconClass='fa-question' value={props.item.question} value_changed={questionChanged} />
                    <TodoStateButton iconClass='fa-road-barrier' value={props.item.blocked} value_changed={blockedChanged}   />
                </div>
                                    
            </div>
            <div className="card-body">
                <TodoChildDropTarget parent={props.item} childrenChanged={props.itemChanged} /> 
                <p className="card-text text-dark text-start">
                    {props.item.text}   
                    <span>{children.length}</span>                                     
                </p>                    
                
                
            </div>
        </div>);    
}

export default TodoComponent;
