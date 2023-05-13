import React from 'react';
import { useEffect} from 'react';
import "reflect-metadata";
import './App.css';
import TodoInput from './components/todo-input'; 
import TopNav from './components/top-nav';
import { AddTodoItemRequest } from './requests/add-todo-item';
import { GetTodoItemsRequest } from './requests/get-todo-items';
import { useState } from 'react';
import TodoItem from './models/todo-item';
import TodoList from './components/todo-list';
import Mediator from './services/mediator';
function App() {
 
  const [items, setItems] = useState<TodoItem[]>([]);

  const onTodoTextEntered = async (text: string) => {

      await Mediator.send(new AddTodoItemRequest(text));
      setItems(await Mediator.send(new GetTodoItemsRequest()));     
  };

  useEffect(()=> {

    async function fetchData() {

      if(!items || items.length === 0)
      {
        setItems(await Mediator.send(new GetTodoItemsRequest()));             
      }
    }

    fetchData();
})

  return (
    <div className="App">
      <header className="App-header">

        <TopNav />  
        <TodoInput onTextEntered={onTodoTextEntered} />      
        <TodoList items={items} /> 

      </header>
    </div>
  );
}

export default App;
