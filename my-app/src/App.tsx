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
function App() {
 
  const [items, setItems] = useState<TodoItem[]>([]);

  const onItemOrderChanged = (changedItems:TodoItem[]) => {

    const changedItemIds = changedItems.map(x=>x.id);
    
    var sortedItems = items.filter(x=> !changedItemIds.includes(x.id))
                 .concat(changedItems)
                 .sort((a,b)=>a.sort_order-b.sort_order);

    setItems(sortedItems);
  }

  const onItemChanged = (changedItem:TodoItem) => {
    var updatedItems = items.filter(x=> changedItem.id != x.id);
    updatedItems.push(changedItem);
    updatedItems = updatedItems.sort((a,b)=>a.sort_order-b.sort_order);
    setItems(updatedItems);
  };

  const onTodoTextEntered = async (text: string) => {

      await new AddTodoItemRequest(text).handle();
      setItems(await new GetTodoItemsRequest().handle());     
  };

  useEffect(()=> {

    async function fetchData() {

      if(!items || items.length === 0)
      {
        const items = await new GetTodoItemsRequest().handle();
        if(items.length > 0)
          setItems(items)            
      }
    }

    fetchData();
})

  return (
    <div className="App">
      <header className="App-header">

        <TopNav />  
        <div className="main-content">
          <TodoInput onTextEntered={onTodoTextEntered} />      
          <TodoList items={items} itemOrderChanged={onItemOrderChanged} itemChanged={onItemChanged} /> 
        </div>
      </header>
    </div>
  );
}

export default App;
