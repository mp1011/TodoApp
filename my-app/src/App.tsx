import React from 'react';
import "reflect-metadata";
import './App.css';
import TodoInput from './components/todo-input'; 
import { AddTodoRequest } from './requests/add-todo';
import { GetTodoItemsRequest } from './requests/get-todo-items';
import { useState } from 'react';
import TodoItem from './models/todo-item';
import TodoComponent from './components/todo-component';
import Mediator from './services/mediator';
function App() {

  
  const [items, setItems] = useState<TodoItem[]>([]);
  const [count, setCount] = useState(0);

  const onTodoTextEntered = (text: string) => {

      Mediator.send(new AddTodoRequest(text));
      setItems(Mediator.send(new GetTodoItemsRequest()));     
      setCount(count+1);
  };

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
