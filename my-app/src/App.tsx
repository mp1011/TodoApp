import React from 'react';
import "reflect-metadata";
import './App.css';
import TodoInput from './components/todo-input'; 
import {AddTodoRequest,AddTodoRequestHandler} from './requests/add-todo';
import { Container } from 'typedi';
import { GetTodoItemsRequest, GetTodoItemsRequestHandler } from './requests/get-todo-items';
import { useState } from 'react';
import TodoItem from './models/todo-item';
import TodoComponent from './components/todo-component';
import DataAccess from './services/data-access';

function App() {

  
  const [items, setItems] = useState<TodoItem[]>([]);
  const [count, setCount] = useState(0);

  const onTodoTextEntered = (text: string) => {

      let handler = Container.get(AddTodoRequestHandler);
      handler.handle(new AddTodoRequest(text));

      let handler2 = Container.get(GetTodoItemsRequestHandler);
      setItems(handler2.handle(new GetTodoItemsRequest()));     
      setCount(count+1);
  };

  Container.get(DataAccess);

  return (
    <div className="App">
      <header className="App-header">

        <TodoInput onTextEntered={onTodoTextEntered} />
        <p>There are {items.length} items</p>
        <p>Count: {count}</p>
        
        <ul>
          {items.map((item) => (
            <li key={item.text}>
              <TodoComponent item={item} />
            </li>
          ))}
        </ul>
        
      </header>
    </div>
  );
}

export default App;
